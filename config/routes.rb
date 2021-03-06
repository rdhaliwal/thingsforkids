Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { invitations: "users/invitations",
                                    registrations: "users/registrations"
                                  }

  root 'listings#index'

  resources :listings, only: [:index, :show, :edit, :update, :create]

  resources :users, only: [:edit, :update]

  resources :my_listings, only: [:index, :edit, :update, :destroy] do
    resources :build_listings, controller: 'my_listings/build_listings'
  end

  resources :messages, only: [:create]
  resources :listing_images, only: [:destroy]

  get 'contact-us', to: 'pages#contact'
  post 'subscribe', to: 'pages#mailchimp_subscription'
  get 'about-us', to: 'pages#about'
  get 'pricing', to: 'pages#pricing'

  mount StripeEvent::Engine, at: '/stripe-events'

  require "resque_web"
  mount ResqueWeb::Engine => "/resque_web"
end
