class Event < ApplicationRecord
  belongs_to :user
  has_many :pledges
  has_one :charity

  validates :category, inclusion: { in: %w[run/walk bike] }

  CATEGORY_OPTIONS = [
    %w[run/walk run/walk],
    %w[bike bike],
  ]

  # after_save :stripe_auto_pay

  # private

  # def stripe_auto_pay
  #   if event_completed_on_changed?
  #     self.pledges.each do |pledge|

  #       product = Stripe::Product.create({
  #         name: pledge.user.email + 'donation' + pledge.id
  #       })

  #       price = Stripe::Price.create({
  #         product: product,
  #         unit_amount: ((@event.amount * pledge.amount)*100).to_i,
  #         currency: 'usd'
  #       })

  #       Stripe::InvoiceItem.create({
  #         customer: pledge.user.stripe_customer_id,
  #         price: price
  #       })

  #       invoice = Stripe::Invoice.create({
  #         customer: pledge.user.stripe_customer_id,
  #         collection_method: 'charge_automatically',
  #         auto_advance: true
  #       })

  #     end
  #   end
  # end

end
