Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'warbles', to: 'warbles#index'
  # verb, path-as-a-string, to: 'controller#action'
  # :id is a 'wildcard'; anything after /warbles/ will be matched
  # get '/warbles/:id', to: 'warbles#show'
  # post '/warbles', to: 'warbles#create'
  # patch '/warbles/:id', to: 'warbles#update'
  # put '/warbles/:id', to: 'warbles#update'
  # delete '/warbles/:id', to: 'warbles#destroy'

  root to: 'static_pages#root'
# format our response to expect json
  namespace :api, defaults: {format: 'json'} do
    resources :warbles, only: [:index, :create, :show]
    resources :users, only: [:index, :show]
  end
  
  resources :warbles, only: [:index, :show, :create, :update, :destroy, :new, :edit]
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  get '/set_cookie', to: 'warbles#set_cookie'
  get '/get_cookie', to: 'warbles#get_cookie'
end
