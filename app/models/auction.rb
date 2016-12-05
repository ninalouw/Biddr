class Auction < ApplicationRecord
  has_many :bids, dependent: :nullify
end
