Rails.application.routes.draw do
  post '/employees/add_record', to: 'employee#add_record'
  post '/employees/link_record', to: 'employee#link_record'
  post '/employees/update_record', to: 'employee#update_record'
  post '/employees/clear_link_record', to: 'employee#clear_link_record'
  post '/employees/find_record', to: 'employee#find_record'
  delete '/customer_record', to: 'customer_record#destroy'
  put '/customer_record', to: 'customer_record#update'
  post '/customer_record', to: 'customer_record#create'
  post '/customer_record/list', to: 'customer_record#list'
  post '/customer_record/find_record', to: 'customer_record#find_record'
  post '/customer_record/add_record', to: 'customer_record#add_record'
  post '/customer_record/link_record', to: 'customer_record#link_record'
  post '/customer_record/update_record', to: 'customer_record#update_record'
  post '/customer_record/clear_link_record', to: 'customer_record#clear_link_record'
  put '/service_mapping', to: 'service_mapping#update'
  post '/service_mapping/list', to: 'service_mapping#list'
  put '/services', to: 'service#update'
  post '/services', to: 'service#create'
  delete '/services', to: 'service#destroy'
  post '/services/list', to: 'service#list'
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
  post '/employees/list', to: 'employee#list'
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
  get '/employee_activation', to: 'employee#activate'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :profiles
  resources :doctor_profile
  resources :station
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
