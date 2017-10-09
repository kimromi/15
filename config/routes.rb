Rails.application.routes.draw do
  root 'app#index'
  get 'app/index'

  get '/auth/:provider/callback', to: 'sessions#create'

  get '/signout', to: 'sessions#destroy'
end
