Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root "home#index"

  resources :home, only: [:index] do
    get 'addresses', on: :collection
  end

  resources :users, only: [:edit, :update]
  resources :my_listings
end
