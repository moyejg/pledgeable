class AccountController < ApplicationController
#this is for the Charity accounts with Stripe
  def create 

    if charity_signed_in? != true
      redirect_to root_path
    end

    @account = Stripe::Account.create({
      type: 'express',
    })

    current_charity.update(stripe_account_id: @account.id)

    @account_links = Stripe::AccountLink.create({
      account: @account,
      refresh_url: account_reauth_url,
      return_url: account_return_url,
      type: 'account_onboarding',
    })

    redirect_to @account_links.url
  end

  def login
    @login_link = Stripe::Account.create_login_link(current_charity.stripe_account_id)
    redirect_to @login_link.url
  end

  def reauth

  end

  def return

  end

end