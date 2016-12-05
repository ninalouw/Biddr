class BidsController < ApplicationController
  def create
    @auction        = Auction.find params[:auction_id]
    bid_params    = params.require(:bid).permit(:bid_amount)
    @bid          = Bid.new bid_params
    @bid.auction = @auction
    # @bid.user     = current_user
    if @bid.save
      redirect_to auction_path(@auction), notice: 'Bid created!'
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
