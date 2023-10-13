Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'

  get 'users/new'
  get 'users/create'
  post 'users/new', to: "users#create"
  root "welcome#index"
  get '/dashboard', to: 'dashboard#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#omniauth'
  get '/password/reset', to: 'password_resets#new'
  post '/password/reset', to: 'password_resets#create'
  get '/password/reset/edit', to: 'password_resets#edit'
  patch '/password/reset/edit', to: 'password_resets#update'
  
  get 'profile/edit', to: 'profile#edit', as: 'profile_edit'
  patch 'profile/update', to: 'profile#update', as: 'profile_update'
  

  # config/routes.rb
  resources :users, only: [:new, :create]
  resources :credits
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
