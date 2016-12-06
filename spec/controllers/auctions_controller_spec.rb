require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  # test new / create actions
  let(:user) { create(:user) }
  describe '#new' do
    context 'with no user signed in' do
      before { request.session[:user_id] = nil }
      it 'redirects to the home page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end
    context 'with user signed in' do
      before { request.session[:user_id] = user.id }
      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'instantiates a new auction object' do
        get :new
        expect(assigns(:auction)).to be_a_new(Auction)
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      before { request.session[:user_id] = user.id }
      def valid_request
        post :create, params: { auction: attributes_for(:auction), user: user }
      end
      it 'saves a record to the database' do
        count_before = Auction.count
        valid_request
        count_after = Auction.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'redirects to the auction show page' do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end
    end
    context 'with invalid params' do
      before { request.session[:user_id] = user.id }
      def invalid_request
        post :create, params: { auction: attributes_for(:auction, title: nil) }
      end
      it 'doesn\'t save a record to the database' do
        count_before = Auction.count
        invalid_request
        count_after = Auction.count
        expect(count_after).to eq(count_before)
      end

      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end
end
