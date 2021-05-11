# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'logs#index'

  resources :users, only: %i[show] do
    resources :logs do
      collection do
        get 'search'
      end
      resources :stocks, only: %i[create destroy]
    end
  end
end
