class Event < ApplicationRecord
  belongs_to :user
  has_many :pledges

  validates :category, inclusion: { in: %w[run/walk bike] }

  CATEGORY_OPTIONS = [
    %w[run/walk run/walk],
    %w[bike bike],
  ]
end
