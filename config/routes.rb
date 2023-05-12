# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  post '/login', to: 'session#create'
  get 'like/create'
  get 'comment/new'
 
  devise_scope :user do
    get 'confirmations/new', to: 'devise/confirmations#new', as: :new_confirmation
  end

  resources :user do
    resources :post do
      get 'new', on: :member
    end
  end

  resources :post do
    member do
      post 'like'
    end
  end
  
  resources :user do
    get 'edit', on: :member

  end
  resources :user, only: [:index, :show] do
    resources :post, only: [:index, :show] 
    resources :comment, only: [:create, :new]
  end
  resources :user do
    resources :post do
      resources :comment, only: [:create, :new]
    end
  end

  namespace :api do
    post 'login', to: 'login#index'
    resources :user, only: [:index] do
      resources :post, only: [:index] do
        resources :comment, only: [:index, :create]
      end
    end
  end

  namespace :api do
    resources :user do
    resources :post, only: [:index, :show, :create, :update, :destroy]
    resources :comment, only: [:index, :create]
  end
  end
  
  # Add a new route for the HTML controller
  resources :users do
    resources :post, only: [:index], controller: 'post'
  end
end
