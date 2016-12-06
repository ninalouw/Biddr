class BidsController < ApplicationController
  def create
    @bids = Bid.order(amount: :DESC)
    @auction        = Auction.find params[:auction_id]
    bid_params    = params.require(:bid).permit(:bid_amount)
    @bid          = Bid.new bid_params
    @bid.auction = @auction
    @bid.user    = current_user
    if @bid.save
      if @auction.published? || @auction.reserve_not_met?
        if @bid.bid_amount > @auction.reserve_price
          @auction.update_attributes(aasm_state: 'reserve_met')
        end
      elsif @auction.reserve_met?
        if @bid.bid_amount > @auction.reserve_price && @auction.max_amount && @auction.ends_on > Time.current
          @auction.update_attributes(aasm_state: 'won')
        end
      end
      redirect_to auction_path(@auction)
    else
      render 'auctions/show'
    end
  end

  def destroy
    @bid = Bid.find params[:id]
    auction = @bid.auction
    if @bid.destroy
      redirect_to auction, notice: 'Bid deleted!'
    else
      redirect_to root_path, alert: 'Access denied'
    end
  end
end
