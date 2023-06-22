Rails.application.routes.draw do
  root to: 'posts#index'
  resources :users
  resources :posts

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
