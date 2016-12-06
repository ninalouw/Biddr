class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, -> { order(created_at: :DESC) }, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: { case_sensitive: false,
                                  message: 'must be unique' }
  validates :details, length: { minimum: 5 }

  include AASM
  aasm whiny_transitions: true do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :won
    state :canceled
    state :reserve_not_met
    event :publish do
      transitions from: :draft, to: :published
    end

    event :met do
      transitions from: :published, to: :reserve_met
    end

    event :win do
      transitions from: [:published, :reserve_met], to: :won
    end

    event :cancel do
      transitions from: [:draft, :published, :won], to: :canceled
    end

    event :not_met do
      transitions from: :published, to: :reserve_not_met
    end

    event :draft do
      transitions from: [:canceled, :published], to: :draft
    end
  end

  def user_full_name
    if user
      user.full_name
    else
      'Anonymous'
    end
  end

  def user_first_name
    user ? user.first_name : 'Anonymous'
  end

  def user_last_name
    user ? user.last_name : 'Anonymous'
  end

  def max_amount
    bids.max.bid_amount
  end
end
