Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :home, only: [:index] do
    get 'addresses', on: :collection
  end

  root "home#index"
end
