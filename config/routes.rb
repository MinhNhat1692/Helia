Rails.application.routes.draw do
  
  get 'support_comment/add'

  get 'support_comment/remove'

  get 'support_ticket/add'

  get 'support_ticket/close'

  get 'support_ticket/open'

  get 'support_ticket/remove'

  delete '/medicine_stock_record', to: 'medicine_stock_record#destroy'
  put '/medicine_stock_record', to: 'medicine_stock_record#update'
  post '/medicine_stock_record', to: 'medicine_stock_record#create'
  post '/medicine_stock_record/list', to: 'medicine_stock_record#list'
  post '/medicine_stock_record/search', to: 'medicine_stock_record#search'
  post '/medicine_stock_record/find', to: 'medicine_stock_record#find'
  
  delete '/medicine_internal_record', to: 'medicine_internal_record#destroy'
  put '/medicine_internal_record', to: 'medicine_internal_record#update'
  post '/medicine_internal_record', to: 'medicine_internal_record#create'
  post '/medicine_internal_record/list', to: 'medicine_internal_record#list'
  post '/medicine_internal_record/search', to: 'medicine_internal_record#search'
  post '/medicine_internal_record/find', to: 'medicine_internal_record#find'
 
  delete '/medicine_prescript_internal', to: 'medicine_prescript_internal#destroy'
  put '/medicine_prescript_internal', to: 'medicine_prescript_internal#update'
  post '/medicine_prescript_internal', to: 'medicine_prescript_internal#create'
  post '/medicine_prescript_internal/list', to: 'medicine_prescript_internal#list'
  post '/medicine_prescript_internal/search', to: 'medicine_prescript_internal#search'
  post '/medicine_prescript_internal/find', to: 'medicine_prescript_internal#find'

  delete '/medicine_external_record', to: 'medicine_external_record#destroy'
  put '/medicine_external_record', to: 'medicine_external_record#update'
  post '/medicine_external_record', to: 'medicine_external_record#create'
  post '/medicine_external_record/list', to: 'medicine_external_record#list'
  post '/medicine_external_record/search', to: 'medicine_external_record#search'
  post '/medicine_external_record/find', to: 'medicine_external_record#find'

  delete '/medicine_prescript_external', to: 'medicine_prescript_external#destroy'
  put '/medicine_prescript_external', to: 'medicine_prescript_external#update'
  post '/medicine_prescript_external', to: 'medicine_prescript_external#create'
  post '/medicine_prescript_external/list', to: 'medicine_prescript_external#list'
  post '/medicine_prescript_external/search', to: 'medicine_prescript_external#search'
  post '/medicine_prescript_external/find', to: 'medicine_prescript_external#find'

  delete '/medicine_price', to: 'medicine_price#destroy'
  put '/medicine_price', to: 'medicine_price#update'
  post '/medicine_price', to: 'medicine_price#create'
  post '/medicine_price/list', to: 'medicine_price#list'
  post '/medicine_price/search', to: 'medicine_price#search'
  post '/medicine_price/find', to: 'medicine_price#find'

  delete '/medicine_bill_record', to: 'medicine_bill_record#destroy'
  put '/medicine_bill_record', to: 'medicine_bill_record#update'
  post '/medicine_bill_record', to: 'medicine_bill_record#create'
  post '/medicine_bill_record/list', to: 'medicine_bill_record#list'
  post '/medicine_bill_record/search', to: 'medicine_bill_record#search'
  post '/medicine_bill_record/find', to: 'medicine_bill_record#find'

  delete '/medicine_bill_in', to: 'medicine_bill_in#destroy'
  put '/medicine_bill_in', to: 'medicine_bill_in#update'
  post '/medicine_bill_in', to: 'medicine_bill_in#create'
  post '/medicine_bill_in/list', to: 'medicine_bill_in#list'
  post '/medicine_bill_in/search', to: 'medicine_bill_in#search'
  post '/medicine_bill_in/find', to: 'medicine_bill_in#find'

  delete '/medicine_sample', to: 'medicine_sample#destroy'
  put '/medicine_sample', to: 'medicine_sample#update'
  post '/medicine_sample', to: 'medicine_sample#create'
  post '/medicine_sample/list', to: 'medicine_sample#list'
  post '/medicine_sample/search', to: 'medicine_sample#search'
  post '/medicine_sample/find', to: 'medicine_sample#find'

  delete '/medicine_company', to: 'medicine_company#destroy'
  put '/medicine_company', to: 'medicine_company#update'
  post '/medicine_company', to: 'medicine_company#create'
  post '/medicine_company/list', to: 'medicine_company#list'
  post '/medicine_company/search', to: 'medicine_company#search'
  post '/medicine_company/find', to: 'medicine_company#find'

  delete '/medicine_supplier', to: 'medicine_supplier#destroy'
  put '/medicine_supplier', to: 'medicine_supplier#update'
  post '/medicine_supplier', to: 'medicine_supplier#create'
  post '/medicine_supplier/list', to: 'medicine_supplier#list'
  post '/medicine_supplier/search', to: 'medicine_supplier#search'
  post '/medicine_supplier/find', to: 'medicine_supplier#find'

  post '/employee/add_record', to: 'employee#add_record'
  post '/employee/link_record', to: 'employee#link_record'
  post '/employee/update_record', to: 'employee#update_record'
  post '/employee/clear_link_record', to: 'employee#clear_link_record'
  post '/employee/find_record', to: 'employee#find_record'
  post '/employee/search', to: 'employee#search'
  
  delete '/customer_record', to: 'customer_record#destroy'
  put '/customer_record', to: 'customer_record#update'
  post '/customer_record', to: 'customer_record#create'
  post '/customer_record/list', to: 'customer_record#list'
  post '/customer_record/find_record', to: 'customer_record#find_record'
  post '/customer_record/add_record', to: 'customer_record#add_record'
  post '/customer_record/link_record', to: 'customer_record#link_record'
  post '/customer_record/update_record', to: 'customer_record#update_record'
  post '/customer_record/clear_link_record', to: 'customer_record#clear_link_record'
  post '/customer_record/search', to: 'customer_record#search'
  
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
