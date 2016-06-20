Rails.application.routes.draw do
  root to: "books#index"

  get "impressum" => "static_pages#impressum"
  get "about" => "static_pages#about"
  get "privacy_policy" => "static_pages#privacy_policy"
  get "terms" => "static_pages#terms"

  resources :articles, only: [:show, :index], param: :slug

  resources :books, only: [:show, :index] do
    resources :chapters, only: [:show]
  end

  get "cart" => "cart#show"
  post "cart/add"
  delete "cart/remove"

  post "payments/pay"

  resources :orders, only: [:show, :index] do
    resources :books, only: [] do
      member do
        get :download_pdf
        get :download_epub
        get :download_mobi
      end
    end
  end
  get "orders/order_completed/:id" => "orders#completed", as: "completed_order"

  get "login" => "authentication#login"
  post "authentication/send_token"
  get "authentication/authenticate_by_token"

  namespace :admin do
    get "/", to: redirect("/admin/orders")
    resources :orders, only: [:index, :show]
    resources :articles, only: [:new, :edit, :create, :update, :destroy], param: :slug
    resources :books, only: [:index, :show] do
      member do
        get :download_pdf
        get :download_epub
        get :download_mobi
      end
    end
  end

  resources :customer_support_requests, only: [:new, :create]

  namespace :api do
    resources :books, only: [:update]
  end

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
