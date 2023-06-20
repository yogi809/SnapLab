Rails.application.routes.draw do
  root to: 'posts#index'
  resources :users
  resources :posts

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
