module Events
  class StripeHandler
    def self.process(event)
      stripe_event = Stripe::Event.construct_from(event.data)
      case stripe_event.type
        when 'customer.created'
          puts 'customer created'
        when 'checkout.session.completed' #when a user puts in their card info
          # explanation of whats happening here can be found at minute 38 of Stripe Webhooks youtube video https://www.youtube.com/watch?v=oYSLhriIZaA
          checkout_session = stripe_event.data.object
          puts 'checkout session completed xoxoxoxoxoxoxoxoxoxoxoxoxo'
          puts "#{checkout_session.customer}"
        when 'account.updated' #when a charity signs up 
          puts 'acount updated xoxoxoxoxoxoxoxoxoxox'
        when 'invoice.payment_succeeded'
          puts 'invoice payment succeeded xoxoxoxoxoxoxoxoxoxoxoxox'
      end
    end
  end
end