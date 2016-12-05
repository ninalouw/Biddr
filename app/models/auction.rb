class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, lambda { order(created_at: :DESC) }, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: { case_sensitive: false,
                                  message: 'must be unique' }
  validates :details, length: { minimum: 5 },
                       uniqueness: { scope: :title }

  def user_full_name
    if user
      user.full_name
    else
      'Anonymous'
    end
  end

  def user_first_name
    user ? user.first_name : "Anonymous"
  end

  def user_last_name
    user ? user.last_name : "Anonymous"
  end
end
