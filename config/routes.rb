Rails.application.routes.draw do
  get 'position/create'

  get 'position/update'

  get 'position/destroy'

  post '/country/list', to: 'nation#list'
  post '/employee', to: 'employee#create'
  delete '/employee', to: 'employee#destroy'
  put '/employee', to: 'employee#update'
  get '/station', to: 'station#new'
  post '/station',   to: 'station#create'
  get '/profiles', to: 'profiles#new'
  post '/profiles',   to: 'profiles#create'
  get '/dprofiles', to: 'doctor_profile#new'
  post '/dprofiles',   to: 'doctor_profile#create'
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
  resources :profiles
  resources :doctor_profile
  resources :station
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
