class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :user

  validates :bid_amount, presence: true

  def user_full_name
    user ? user.full_name : "Anonymous"
  end
end
