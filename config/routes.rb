Rails.application.routes.draw do
  resources :sessions
  resources :client_services, defaults: {format: :json}
  resources :tag_mutexes, defaults: {format: :json}
  resources :user_tags, defaults: {format: :json}
  resources :users, defaults: {format: :json}
  resources :tags, defaults: {format: :json}
  root :controller => 'sessions', :action => 'index'
end
