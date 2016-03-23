Rails.application.routes.draw do
  root to: "books#index"

  get "impressum" => "static_pages#impressum"
  get "privacy_policy" => "static_pages#privacy_policy"
  get "terms" => "static_pages#terms"

  resources :books, only: [:show, :index]
end
