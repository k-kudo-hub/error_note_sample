# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'logs#index'
  resources :users, only: %i[show] do
    resources :logs do
      collection do
        get 'search'
      end
    end
  end
  get 'terms', to: 'terms#index'
  get 'privacy', to: 'privacies#index'

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [] do
        collection do
          get 'show'
          get 'user_log_index'
          get 'authentication'
        end
      end
      resources :logs, only: [] do
        collection do
          get 'index'
          get 'latest_stocks_index'
          get 'most_stocked_index'
          post 'create'
          get 'show'
          put 'update'
          get 'search'
          delete 'destroy'
        end
      end
      resources :languages, only: [] do
        collection do
          get 'index'
          get 'rank'
        end
      end
      resources :stocks, only: [] do
        collection do
          get 'index'
          post 'create'
          delete 'destroy'
          get 'rank'
          get 'check'
        end
      end
      resources :notifications, only: [] do
        collection do
          get 'index'
          get 'show'
          get 'show_below_header'
        end
      end
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
