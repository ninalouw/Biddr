class AuctionsController < ApplicationController
  # before_action :authenticate_user, except: [:index, :show]
  before_action :find_auction, only: [:edit, :update, :destroy, :show]

  def new
  @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
    # @auction.user = current_user
    if @auction.save
      flash[:notice] = 'Auction Created!'
      redirect_to auction_path(@auction)
    else
      flash.now[:alert] = 'Please see errors below'
      render :new
    end
  end

  def show
    @bid = Bid.new
  end

  def index
    @auction = Auction.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @auction.update auction_params
      flash[:notice] = 'Auction updated'
      redirect_to auction_path(@auction)
    else
      flash.now[:alert] = 'Please see errors below!'
      render :edit
    end
  end

  def destroy
    @auction.destroy
    redirect_to auctions_path, notice: 'Auction deleted'
  end

  private
  def auction_params
    params.require(:auction).permit([:title, :details, :ends_on, :reserve_price])
  end

  def find_auction
    @auction = Auction.find params[:id]
  end
end
