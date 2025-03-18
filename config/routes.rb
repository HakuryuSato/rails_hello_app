Rails.application.routes.draw do
  get "sessions/new"
  # ルート
  root "static_pages#home"

  # 1章
  resources :microposts
  resources :users

  # 3章 static_pages
  %w[home help about contact].each do |page|
    get "/#{page}", to: "static_pages##{page}"
  end

  # 5章 users
  get "/signup",  to: "users#new"

  # 8章 セッション
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check
end
