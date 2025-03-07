Rails.application.routes.draw do
  root "static_pages#home"

  # 1章
  resources :microposts
  resources :users

  # 3章 static_pages
  %w[home help about contact].each do |page|
    get "static_pages/#{page}", to: "static_pages##{page}"
  end

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check
end
