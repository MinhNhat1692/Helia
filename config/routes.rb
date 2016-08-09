Rails.application.routes.draw do
  get 'home/new'
  get 'users/new'
  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
