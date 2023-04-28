Rails.application.routes.draw do
  root "games#index"
  resources :involved_companies
  resources :genres
  resources :platforms
  resources :games
  resources :critics
  resources :companies
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
