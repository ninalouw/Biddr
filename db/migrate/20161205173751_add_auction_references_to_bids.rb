class AddAuctionReferencesToBids < ActiveRecord::Migration[5.0]
  def change
    add_reference :bids, :auction, foreign_key: true
  end
end
