Rails.application.routes.draw do
  root 'top#index'
  get 'top/index'

  get '/auth/:provider/callback', to: 'sessions#create'

  get '/app', to: 'app#index'
  get '/signout', to: 'sessions#destroy'
end
