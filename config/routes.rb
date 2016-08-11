Rails.application.routes.draw do
  get 'home/new'
  get 'users/new'
  root "home#index"
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get 'users/check_email', to: "users#check_email"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
