Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :auctions do
    resources :bids, only:[:create, :destroy]
  end
end
