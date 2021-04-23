Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'logs#index'
  resources :users, only: [:index, :show] do
    resources :logs,  only: [:index, :new, :create, :show, :edit, :update] do
      resources :stocks, only: [:create, :destroy]
    end
  end
end
