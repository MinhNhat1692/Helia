Rails.application.routes.draw do
  get '/profiles', to: 'profiles#new'
  post '/profiles',   to: 'profiles#create'
  root "home#index"
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get 'users/check_email', to: "users#check_email"
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
