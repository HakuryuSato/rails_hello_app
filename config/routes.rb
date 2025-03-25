# frozen_string_literal: true

Rails.application.routes.draw do
  # ルート
  root 'static_pages#home'

  # 1章
  resources :microposts
  resources :users

  # 3章 static_pages
  get '/home',   to: 'static_pages#home'
  get '/help',   to: 'static_pages#help'
  get '/about',  to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # 5章 users
  get '/signup',  to: 'users#new'

  # 8章 セッション
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # ヘルスチェック
  get 'up' => 'rails/health#show', as: :rails_health_check
end
