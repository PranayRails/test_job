Rails.application.routes.draw do
  resources :train_bookings
  resources :parcels
  resources :post_masters
  resources :trains
  get 'home/index'
  devise_for :users
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
