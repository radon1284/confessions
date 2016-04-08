Rails.application.routes.draw do
  root to: "books#index"

  get "impressum" => "static_pages#impressum"
  get "privacy_policy" => "static_pages#privacy_policy"
  get "terms" => "static_pages#terms"

  resources :books, only: [:show, :index]

  get "cart" => "cart#show"
  post "cart/add"
  delete "cart/remove"

  post "payments/pay"

  resources :orders, only: [:show, :index]

  get "login" => "authentication#login"
  post "authentication/send_token"
  get "authentication/authenticate_by_token"

  resources :customer_support_requests, only: [:new, :create]

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
