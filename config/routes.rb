Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/flips', to: 'flips#index'
  # get '/flips/:id', to: 'flips#show'
  # post '/flips', to: 'flips#create'
  # patch '/flips/:id', to: 'flips#update'
  # put '/flips/:id', to: 'flips#update'
  # delete '/flips/:id', to: 'flips#destroy'
  # :id is a wildcard

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :flips, only: [:index, :show, :create, :update, :destroy, :new, :edit]
  get '/get_cookie', to: 'flips#get_cookie'
  get '/set_cookie', to: 'flips#set_cookie'

end
