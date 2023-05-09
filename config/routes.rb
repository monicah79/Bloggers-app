# frozen_string_literal: true

Rails.application.routes.draw do
  get 'like/create'
  get 'comment/new'
  devise_for :users
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
end
