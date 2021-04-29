Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'logs#index'
  resources :users, only: [:index, :show] do
    resources :logs do
      collection do
        get 'search'
      end
      resources :stocks, only: [:create, :destroy]
    end
  end
end
