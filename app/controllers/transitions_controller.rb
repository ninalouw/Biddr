class TransitionsController < ApplicationController
  before_action :authenticate_user

  def create_draft
    @auction = Auction.find params[:auction_id]
    if @auction.draft!
      redirect_to @auction, notice: 'Auction drafted!'
    else
      redirect_to @auction, alert: 'Can\'t draft Auction'
    end
  end

  def create_publish
    @auction = Auction.find params[:auction_id]
    if @auction.publish!
      redirect_to @auction, notice: 'Auction published!'
    else
      redirect_to @auction, alert: 'Can\'t publish Auction'
    end
  end

  def create_met
    @auction = Auction.find params[:auction_id]
    if @auction.met!
      redirect_to @auction, notice: 'Auction met!'
    else
      redirect_to @auction, alert: 'Auction cannot be met'
    end
  end

  def create_win
    @auction = Auction.find params[:auction_id]
    if @auction.win!
      redirect_to @auction, notice: 'Auction won!'
    else
      redirect_to @auction, alert: 'Auction cannot be won'
    end
  end

  def create_cancel
    @auction = Auction.find params[:auction_id]
    if @auction.cancel!
      redirect_to @auction, notice: 'Auction canceled!'
    else
      redirect_to @auction, alert: 'Auction cannot be canceled'
    end
  end

  def create_not_met
    @auction = Auction.find params[:auction_id]
    if @auction.not_met!
      redirect_to @auction, notice: 'Auction not met!'
    else
      redirect_to @auction, alert: 'Auction cannot be not met'
    end
  end
end
