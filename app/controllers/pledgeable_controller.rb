class PledgeableController < ApplicationController
  def home
    @events = Event.all
  end
end
