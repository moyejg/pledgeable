class Event < ApplicationRecord
  after_save :stripe_auto_transfer, if: :saved_change_to_event_completed_on? 

  belongs_to :user
  belongs_to :charity, optional: true
  belongs_to :event_category, optional: true
  has_many :pledges

  def total_pledge_amount
    pledge_amount_arr = []
    self.pledges.each do |pledge|
      pledge_amount_arr.push(pledge.amount)
    end
    amount = pledge_amount_arr.sum
    return amount
  end

  private

    def stripe_auto_transfer    
      self.pledges.each do |pledge|

        product = Stripe::Product.create({
          name: pledge.user.email + 'donation' + pledge.id.to_s
        })
        
        if pledge.max_amount < (self.amount * pledge.amount)
          price = Stripe::Price.create({
          product: product,
          unit_amount: (pledge.max_amount*100).to_i,
          currency: 'usd'
        })
        else
          price = Stripe::Price.create({
            product: product,
            unit_amount: ((self.amount * pledge.amount)*100).to_i,
            currency: 'usd'
          })
        end

        Stripe::InvoiceItem.create({
          customer: pledge.user.stripe_customer_id,
          price: price
        })

        invoice = Stripe::Invoice.create({
          customer: pledge.user.stripe_customer_id,
          collection_method: 'charge_automatically',
          auto_advance: true,
          transfer_data: {
            destination: pledge.event.charity.stripe_account_id,
            amount: ( price.unit_amount * 0.95 ).to_i
          }
        })

      end

    end

  end


