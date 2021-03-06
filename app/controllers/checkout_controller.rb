class CheckoutController < ApplicationController

  def create

    if user_signed_in? != true
      redirect_to root_path
    end

    @customer = Stripe::Customer.create({
      email: current_user.email
    })

    current_user.update(stripe_customer_id: @customer.id)

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      mode: 'setup',
      customer: @customer,
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js # render create.js.erb
    end

  end

  def success

  end

  def cancel

  end
  
end
