Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :articles do
  	resources :comments
  end
  
  devise_for :users
  	resources :users
  root 'welcome#index'
end
