class EventCategory < ApplicationRecord
  has_many :events

  rails_admin do 
    edit do
      field :name
      field :description
      field :unit_of_measurement
    end
  end
end
