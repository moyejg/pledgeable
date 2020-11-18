class Event < ApplicationRecord
  after_save :stripe_auto_pay, if: :saved_change_to_event_completed_on? 

  belongs_to :user
  belongs_to :charity
  has_many :pledges

  validates :category, inclusion: { in: %w[run/walk bike] }

  CATEGORY_OPTIONS = [
    %w[run/walk run/walk],
    %w[bike bike],
  ]

  private

    def stripe_auto_pay    
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
          auto_advance: true
        })

      end

    end

    def charity_pay_out
   
    end

  end


