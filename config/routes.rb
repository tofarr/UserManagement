Rails.application.routes.draw do
  resources :tag_mutexes, defaults: {format: :json}
  resources :user_tags, defaults: {format: :json}
  resources :users, defaults: {format: :json}
  resources :tags, defaults: {format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
