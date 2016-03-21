Rails.application.routes.draw do
  root to: "static_pages#index"

  get "impressum" => "static_pages#impressum"
  get "privacy_policy" => "static_pages#privacy_policy"
  get "terms" => "static_pages#terms"
  get "submit_your_story" => "static_pages#submit_your_story"
end
