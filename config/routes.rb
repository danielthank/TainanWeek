Rails.application.routes.draw do
  root 'welcome#index'

  get 'week' => 'week#index', as: 'week'
  get 'night' => 'night#index', as: 'night'

  get 'user/new' => 'users#new', as: 'user_new'
  post 'user/new' => 'users#create'
  get 'user/login' => 'users#login', as: 'user_login'
  post 'user/login' => 'users#determine'

  get 'user/logout' => 'users#logout', as: 'user_logout'

end
