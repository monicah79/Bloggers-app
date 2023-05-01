# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user, only: [:index, :show] do
    resources :post, only: [:index, :show] 
  end
end
