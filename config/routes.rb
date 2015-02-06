Rails.application.routes.draw do
  root 'welcome#index'
  get  ':id' => 'welcome#index'
end
