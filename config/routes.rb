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

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :users, only: [] do
        collection do
          get 'authentication'
        end
      end
      resources :logs, only: [] do
        collection do
          get 'index'
          get 'latest_stocks'
          get 'most_stocked_logs'
          post 'create'
          get 'search'
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
          get 'rank'
        end
      end
      resources :log_languages, only: [] do
        collection do
          post 'create'
        end
      end
    end
  end
end
