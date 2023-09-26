Rails.application.routes.draw do

  get 'users/new'
  get 'users/create'
  post 'users/new', to: "users#create"
  root "welcome#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
