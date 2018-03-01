Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :articles do
  	resources :comments
  end
  
  get 'tags/:tag', to: 'articles#index', as: :tag
  
  devise_for :users
  	resources :users
  root 'welcome#index'
end
