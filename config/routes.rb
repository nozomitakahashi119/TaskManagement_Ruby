Rails.application.routes.draw do
  get 'toppages/index'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  root to: 'toppages#index' #メインページの設定
  
  get 'signup', to:'users#new'
  resources :tasks
  resources :users, only: [:index, :show, :new, :create]
end