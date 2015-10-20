Rails.application.routes.draw do
  devise_for :users
  
  get 'customer/signup', :to => 'customers#new'
  get 'business/signup', :to => 'businesses#new'
  root 'dashboard#index'
  
  resources :dashboard
  resources :customers
  resources :businesses
end
