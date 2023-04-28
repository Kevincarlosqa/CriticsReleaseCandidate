Rails.application.routes.draw do
  devise_for :users
  root "games#index"
  resources :involved_companies
  resources :genres
  resources :platforms
  resources :games do
    resources :critics, only: :create
  end
  resources :critics
  resources :companies  do
    resources :critics, only: :create
  end
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
