Rails.application.routes.draw do

  post '/apikey/getkey', to: 'apikey#getkey'
  post '/apikey/changekey', to: 'apikey#changekey'
  post '/apikey/addkey', to: 'apikey#addkey'

  post '/room_manager/list', to: 'room_manager#list'

  delete '/bill_info', to: 'bill_info#destroy'
  put '/bill_info', to: 'bill_info#update'
  post '/bill_info/list', to: 'bill_info#list'
  post '/bill_info/search', to: 'bill_info#search'
  post '/bill_info/find', to: 'bill_info#find'

  delete '/doctor_check_info', to: 'doctor_check_info#destroy'
  put '/doctor_check_info', to: 'doctor_check_info#update'
  put '/doctor_check_info/order_map', to: 'doctor_check_info#updatesmall'
  post '/doctor_check_info/list', to: 'doctor_check_info#list'
  post '/doctor_check_info/search', to: 'doctor_check_info#search'
  post '/doctor_check_info/find', to: 'doctor_check_info#find'

  delete '/check_info', to: 'check_info#destroy'
  put '/check_info', to: 'check_info#update'
  put '/check_info/order_map', to: 'check_info#updatesmall'
  post '/check_info/list', to: 'check_info#list'
  post '/check_info/search', to: 'check_info#search'
  post '/check_info/find', to: 'check_info#find'
  post '/check_info/end', to: 'check_info#finish'
  post '/check_info/call', to: 'check_info#call'

  post '/doctor_room/extra', to: 'order_map#extra'
  delete '/order_map', to: 'order_map#destroy'
  put '/order_map', to: 'order_map#update'
  post '/order_map', to: 'order_map#create'
  post '/order_map/list', to: 'order_map#list'
  post '/order_map/search', to: 'order_map#search'
  post '/order_map/find', to: 'order_map#find'
  post '/order_map/end', to: 'order_map#finish'
  post '/order_map/call', to: 'order_map#call'

  delete '/support/comment', to: 'support#deletecomment'
  post '/support/comment', to: 'support#addcomment'
  post '/support/list', to: 'support#listticket'
  post '/support/ticketinfo', to: 'support#ticketinfo'
  post '/support/ticket', to: 'support#addticket'
  delete '/support/ticket', to: 'support#deleteticket'
  put '/support/ticket', to: 'support#closeticket'

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
  post '/employee/find', to: 'employee#find'
  post '/employee/list', to: 'employee#list'
  post '/employee', to: 'employee#create'
  delete '/employee', to: 'employee#destroy'
  put '/employee', to: 'employee#update'
  get '/employee_activation', to: 'employee#activate'

  delete '/customer_record', to: 'customer_record#destroy'
  put '/customer_record', to: 'customer_record#update'
  put '/customer_record/order_map', to: 'customer_record#update'
  post '/customer_record', to: 'customer_record#create'
  post '/customer_record/list', to: 'customer_record#list'
  post '/customer_record/find_record', to: 'customer_record#find_record'
  post '/customer_record/add_record', to: 'customer_record#add_record'
  post '/customer_record/link_record', to: 'customer_record#link_record'
  post '/customer_record/update_record', to: 'customer_record#update_record'
  post '/customer_record/clear_link_record', to: 'customer_record#clear_link_record'
  post '/customer_record/search', to: 'customer_record#search'
  post '/customer_record/find', to: 'customer_record#find'

  put '/sermap', to: 'service_mapping#update'
  post '/sermap', to: 'service_mapping#create'
  delete '/sermap', to: 'service_mapping#destroy'
  post '/sermap/list', to: 'service_mapping#list'
  post '/sermap/search', to: 'service_mapping#search'
  post '/sermap/find', to: 'service_mapping#find'

  put '/service', to: 'service#update'
  post '/service', to: 'service#create'
  delete '/service', to: 'service#destroy'
  post '/service/list', to: 'service#list'
  post '/service/search', to: 'service#search'
  post '/service/find', to: 'service#find'

  put '/posmap', to: 'position_mapping#update'
  post '/posmap', to: 'position_mapping#create'
  delete '/posmap', to: 'position_mapping#destroy'
  post '/posmap/list', to: 'position_mapping#list'
  post '/posmap/search', to: 'position_mapping#search'
  post '/posmap/find', to: 'position_mapping#find'

  put '/room', to: 'room#update'
  post '/room', to: 'room#create'
  delete '/room', to: 'room#destroy'
  post '/room/list', to: 'room#list'
  post '/room/search', to: 'room#search'
  post '/room/find', to: 'room#find'

  put '/position', to: 'position#update'
  delete '/position', to: 'position#destroy'
  post '/position', to: 'position#create'
  post '/position/list', to: 'position#list'
  post '/position/search', to: 'position#search'
  post '/position/find', to: 'position#find'


  post '/country/list', to: 'nation#list'

  get '/station', to: 'station#new'
  post '/station',   to: 'station#create'

  get '/dprofile', to: 'doctor_profile#new'
  post '/dprofile',   to: 'doctor_profile#create'
  post '/dprofile/update', to: 'doctor_profile#update'

  root "home#index"
  get '/changelogs', to: 'home#changelog'
  post '/changelogs', to: 'home#changelogfind'
  get '/news', to: 'home#news'
  post '/news', to: 'home#newsfind'
  get '/features', to: 'home#features'
  get '/pricing', to: 'home#pricing'
  get '/enterprise', to: 'home#enterprise'
  get '/enterprise/demo', to: 'home#demo'
  post '/enterprise/demo', to: 'home#demoadd'
  get '/documentation', to: 'home#documentation'
  get '/documentation/guides', to: 'home#documentation_guide'
  post '/documentation/guides', to: 'home#documentation_guide_request'
  get '/documentation/guides/gettingstarted', to: 'home#documentation_guide', :sub_id => 1
  get '/documentation/guides/indexing', to: 'home#documentation_guide', :sub_id => 3
  get '/documentation/guides/search', to: 'home#documentation_guide', :sub_id => 1
  get '/documentation/guides/relevance', to: 'home#documentation_guide', :sub_id => 1
  get '/documentation/guides/geosearch', to: 'home#documentation_guide', :sub_id => 1
  get '/documentation/guides/security', to: 'home#documentation_guide', :sub_id => 1
  get '/documentation/guides/analytics', to: 'home#documentation_guide', :sub_id => 1
  get '/documentation/guides/account', to: 'home#documentation_guide', :sub_id => 1

  get  '/signup',  to: 'users#usershow'
  post '/signup',  to: 'users#create'
  get '/user', to: 'users#show'

  get 'users/check_email', to: "users#check_email"

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/logout',  to: 'sessions#destroy'

  get '/profile', to: 'profiles#new'
  post '/profile', to: 'profiles#create'

  post '/medicine_summary/external_record', to: 'medicine_external_record#summary'
  post '/medicine_summary/external_record/detail', to: 'medicine_external_record#sub_summary'
  post '/medicine_summary/internal_record', to: 'medicine_internal_record#summary'
  post '/medicine_summary/internal_record/detail', to: 'medicine_internal_record#sub_summary'
  post '/medicine_summary/all', to: 'medicine_all_records#summary'
  post '/medicine_summary/bill_in_status', to: 'medicine_all_records#bill_status'
  post '/medicine_summary/sale_record', to: 'medicine_all_records#sale_record'
  post '/medicine_summary/stock_record', to: 'medicine_stock_record#summary'
  post '/medicine_summary/stock_record/detail1', to: 'medicine_stock_record#detail'
  post '/medicine_summary/stock_record/detail2', to: 'medicine_stock_record#detail_2'
  post '/medicine_summary/supplier', to: 'medicine_bill_in#summary'
  post '/medicine_summary/supplier/detail1', to: 'medicine_bill_record#summary'
  post '/medicine_summary/supplier/detail2', to: 'medicine_stock_record#statistic'
  post '/medicine_summary/sale_stats', to: 'medicine_internal_record#statistic'
  post '/medicine_summary/general_stats', to: 'medicine_internal_record#sale'

  post '/services/overview', to: 'order_map#summary'

  post '/station/pool', to: 'polls#list'
  get '/station/permission', to: 'permissions#owner_list'
  post '/doctor/permission', to: 'permissions#doctor_list'
  
  post '/permissions', to: 'permissions#create'
  put '/permissions', to: 'permissions#update'
  delete '/permissions', to: 'permissions#destroy'

  get '/blogs', to: 'news#index'
  get '/blogs/:link', to: 'news#show'

  post 'api/add_customer/:key', to: 'demo_api#add_customer'
  get 'api/services/:key', to: 'demo_api#list_service'
  get 'api/getResult/:key', to: 'demo_api#get_result'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :doctor_profile
  resources :station
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
