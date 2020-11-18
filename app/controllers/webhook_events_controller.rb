class WebhookEventsController < ApplicationController
#Ignore CSRF
skip_before_action :verify_authenticity_token

  #process notification
  #save and process
  #verify sigs, save and process
  #verify sigs, save and process later
  def create
    case params[:source]
    when 'stripe'
      case params[:type]
      when 'checkout.session.completed' #when a user puts in their card info
        puts 'checkout session completed xoxoxoxoxoxoxoxoxoxoxoxoxo'
      when 'account.updated' #when a charity signs up 
        puts 'acount updated xoxoxoxoxoxoxoxoxoxox'
      when 'invoice.payment_succeeded'
        puts 'invoice payment succeeded xoxoxoxoxoxoxoxoxoxoxoxox'
      end
    #when 'github'
    #when 'twilio'
    end
      
    render json: params
  end
end
