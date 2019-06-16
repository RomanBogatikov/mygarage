Rails.application.routes.draw do

  # resources :cars
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  # resources :users
  # get 'home/index'
  root 'home#index'

  resources :sessions, only: [:new, :create, :destroy]

  resources :services

  resources :users do
    # resources :cars
    # we want all cars belong to users
    resources :cars, only: [:index, :new]
  end

  resources :cars do
    resources :services, only: [:index, :new]
  end

  # resources :cars, only: [:create, :show, :update, :edit, :destroy]




  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # get '/users/:user_id/cars/new', to: 'cars#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
