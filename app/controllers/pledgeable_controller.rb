class PledgeableController < ApplicationController
  def home
    @events = Event.all
  end

  def charities
    @charities = Charity.all
  end

  def user_profile
    @user = User.find(params[:id])
  end
end
