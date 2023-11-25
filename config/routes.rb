Rails.application.routes.draw do
  get '/password/reset', to: 'password_resets#new'
  post '/password/reset', to: 'password_resets#create'
  get '/password/reset/edit', to: 'password_resets#edit', as: 'password_reset_edit'
  patch '/password/reset/edit', to: 'password_resets#update'

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
  
  get 'profile/edit', to: 'profile#edit', as: 'profile_edit'
  patch 'profile/update', to: 'profile#update', as: 'profile_update'
  
  get '/renew', to: 'credits#renew'
  get '/visualize', to: 'credits#visualize', as: 'visualize'
  get 'print', to: 'prints#show', as: 'print'

  get 'admin', to: 'admin#index'
  get 'admin_login', to: 'sessions#admin_new'
  post 'admin_login', to: 'sessions#admin_create'
  delete 'admin_logout', to: 'sessions#admin_destroy'
  get 'user_overview', to: 'admin#user_overview'
  post 'change_user_role', to: 'admin#change_user_role'
  delete 'delete_user', to: 'admin#delete_user'

  # config/routes.rb
  resources :users do
    member do
      get :renewal_date
      put :set_renewal_date
    end
  end
  resources :credits do
    post 'renew', on: :collection
  end
  resources :credit_types
  resources :prints, only: [:show]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
