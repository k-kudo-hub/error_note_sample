# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'logs#index'
  resources :users, only: %i[index show] do
    resources :logs, only: %i[index new create show edit update] do
      resources :stocks, only: %i[create destroy]
    end
  end
end
