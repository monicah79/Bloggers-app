# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  root 'user#index'
  resources :user, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do 
      resources :comments, only: [ :new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
    namespace :api do
    post 'login', to: 'login#index'
    resources :users, only: [:index] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end
end