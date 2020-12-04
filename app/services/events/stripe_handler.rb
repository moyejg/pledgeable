module Events
  class StripeHandler
    def self.process(event)
      stripe_event = Stripe::Event.construct_from(event.data)
      case stripe_event.type
        # when 'customer.created'
        #   puts 'customer created'
        when 'checkout.session.completed' #when a user puts in their card info
          # explanation of whats happening here can be found at minute 38 of Stripe Webhooks youtube video https://www.youtube.com/watch?v=oYSLhriIZaA
          checkout_session = stripe_event.data.object
          
          payment_method = checkout_session.setup_intent.payment_method
          customer = checkout_session.customer

          Stripe::PaymentMethod.attach(
            payment_method,
            customer: customer
            )
          
          Stripe::Customer.update(
            customer,
            invoice_settings: {
              default_payment_method: payment_method
            }
          )

        # when 'account.updated' #when a charity signs up 
          
        # when 'invoice.payment_succeeded'
          
      end
    end
  end
end