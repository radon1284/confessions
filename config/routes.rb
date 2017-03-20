Rails.application.routes.draw do
  root to: "static_pages#home"

  get "impressum" => "static_pages#impressum"
  get "about" => "static_pages#about"
  get "privacy_policy" => "static_pages#privacy_policy"
  get "terms" => "static_pages#terms"

  get 'feed' => 'articles#feed', constraints: { format: "rss" }, format: true


  resources :articles, only: [:show, :index], param: :slug

  # keep responding to old book URL but redirect it
  get '/books/entreprenerd-seo-paid-advertising-and-conversion-optimisation/', to: redirect('/books/entreprenerd/marketing_for_programmers')
  get '/books/entreprenerd', to: redirect('/books/entreprenerd/marketing_for_programmers')
  resources :books, only: [:show, :index] do
    member do
      get :marketing_for_programmers
      get :download_pdf_preview
    end
  end

  get "cart" => "cart#show"
  post "cart/add"
  delete "cart/remove"

  post "payments/pay"

  resources :orders, only: [:show, :index] do
    resources :watermarked_books, only: [] do
      member do
        get :download_pdf
        get :download_epub
        get :download_mobi
      end
    end
    resources :invoice_requests, only: [:new, :create, :show]
  end
  get "orders/order_completed/:id" => "orders#completed", as: "completed_order"

  get "login" => "authentication#login"
  post "authentication/send_token"
  get "authentication/authenticate_by_token"

  namespace :admin do
    get "/", to: redirect("/admin/orders")
    resources :orders, only: [:index, :show]
    resources :articles, only:
      [:index, :new, :edit, :create, :update], param: :slug
    resources :books, only: [:index, :show, :edit, :update] do
      member do
        get :download_pdf
        get :download_epub
        get :download_mobi
      end
    end
    resources :photos, only: [:index, :create, :destroy, :new]
    resources :financial_transactions_reports, only: [:new, :create, :index]
  end

  resources :customer_support_requests, only: [:new, :create]

  namespace :api do
    resources :books, only: [:update]
  end

  get ".well-known/acme-challenge/9EqJmv1zO1_upKSt1CYzddZosF5oHaq5xKSMLWggmAY", to: proc {|env| [200, {}, ["9EqJmv1zO1_upKSt1CYzddZosF5oHaq5xKSMLWggmAY.N-o_utQ9dYQSBk126FSfqj-q7twFqACVQISu3ZIKiIY"]] }

  # redirects from legacy website where we had articles
  # such as "http://www.jackinsella/2014/06/17/awareness-through-jargon.html"
  get "/:year/:month/:date/:article_name", to: redirect { |path_params, _|
    "/articles/#{path_params[:article_name].split('.').first}"
  }

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
