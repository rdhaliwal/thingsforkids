Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root "listings#index"

  resources :listings, only: [:index, :show] do
    get 'addresses', on: :collection
  end

  resources :users, only: [:edit, :update]

  resources :my_listings, only: [:index, :new, :create] do
    get 'pricing', on: :collection
  end
end
