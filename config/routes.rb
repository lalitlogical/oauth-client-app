Rails.application.routes.draw do
  devise_for :users, skip: [ :registrations, :passwords, :confirmations ]

  # Only allow callback handling
  devise_scope :user do
    get "/users/auth/:provider/callback", to: "users/omniauth_callbacks#<provider>"
    delete "/logout", to: "devise/sessions#destroy", as: :logout
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/login", to: "oauth#login"
  get "/callback", to: "oauth#callback"
  get "/protected", to: "oauth#protected"
  delete "/logout", to: "oauth#destroy"

  # config/routes.rb
  namespace :api do
    namespace :v1 do
      get "/me", to: "me#show"
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "home#index"
end
