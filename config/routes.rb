Rails.application.routes.draw do
  put '/position_mapping', to: 'position_mapping#update'
  post '/position_mapping/list', to: 'position_mapping#list'
  put '/rooms', to: 'room#update'
  post '/rooms', to: 'room#create'
  delete '/rooms', to: 'room#destroy'
  post '/rooms/list', to: 'room#list'
  put '/positions', to: 'position#update'
  delete '/positions', to: 'position#destroy'
  post '/positions', to: 'position#create'
  post '/positions/list', to: 'position#list'
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
  get '/logout',  to: 'sessions#destroy'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :profiles
  resources :doctor_profile
  resources :station
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
