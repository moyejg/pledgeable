class WebhookEventsController < ApplicationController
#Ignore CSRF
skip_before_action :verify_authenticity_token

  #process notification
  #save and process
  #verify sigs, save and process
  #verify sigs, save and process later
  def create
    if !valid_signatures?
      render json: { message: "Invalid sigs" }, status: 400
      return
    end
    #idempotent
    if !WebhookEvent.find_by(source: params[:source], external_id: external_id).nil?
      render json: { message: "Already processed #{ external_id }"}
      return
    end

    event = WebhookEvent.create(webhook_params)
    ProcessEventsJob.perform_later(event.id) 
    render json: params
  end

  def valid_signatures?
    if params[:source] == 'stripe'
      begin
        wh_secret = Rails.application.credentials.dig(:stripe, :wh)
        Stripe::Webhook.construct_event(
          request.body.read,
          request.env['HTTP_STRIPE_SIGNATURE'],
          wh_secret
        )
      rescue Stripe::SignatureVerificationError => e
        return false
      end
    end
    true
  end

  def external_id
    return params[:id] if params[:source] == 'stripe' #stripe id should look like "evt_xxxxx"
    SecureRandom.hex
  end

  def webhook_params
    {
      source: params[:source],
      data: params.except(:source, :action, :controller).permit!,
      external_id: external_id
    }
  end
end
