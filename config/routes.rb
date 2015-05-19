Rails.application.routes.draw do
  root 'static_pages#home'
  get 'help'  =>'static_pages#help'
  get 'home'  =>'static_pages#home'
  get 'about'=> 'static_pages#about'
  get 'contact'=> 'static_pages#contact'
  get 'signup' => 'users#new'
  get 'users/show'=>'users#show'
  get 'login'=>'sessions#new'
  post 'login'=>'sessions#create'
  delete 'logout'=>'sessions#destroy'

  resources :users
  end