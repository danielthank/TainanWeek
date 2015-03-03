Rails.application.routes.draw do
  root 'welcome#index'

  get 'week' => 'week#index', as: 'week'
  get 'night' => 'night#index', as: 'night'

end
