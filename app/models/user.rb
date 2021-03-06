class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true

  has_one_attached :avatar
  has_many :events
  has_many :pledges

  def total_money_raised
    self.events.each do |event|
      
    end
  end
end
