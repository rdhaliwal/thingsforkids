Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { invitations: "users/invitations",
                                    registrations: "users/registrations"
                                  }

  root 'listings#index'

  resources :listings, only: [:index, :show] do
    get 'addresses', on: :collection
  end

  resources :users, only: [:edit, :update]

  resources :my_listings, only: [:index, :edit, :update, :destroy] do
    get 'pricing', on: :collection
    resources :build_listings, controller: 'my_listings/build_listings'
  end

  resources :messages, only: [:create]
  get 'contact-us', to: 'pages#contact'
  post 'subscribe', to: 'pages#mailchimp_subscription'
  get 'about-us', to: 'pages#about'
end
