Rails.application.routes.draw do
  root 'teams#new'
  resources :teams, only: %i(new create)
  resources :sessions, only: %i(create)

  get 'app/index'

  get '/auth/:provider/callback', to: 'sessions#create'

  get '/signout', to: 'sessions#destroy'

  namespace :api, { format: :json } do
    namespace :v1 do
      get '/records/:date', to: 'records#index'
      resources :records, only: %i(create)

      get :teams, to: 'team#index'
      get :team, to: 'team#show'
      resources :tasks, only: %i(index create destroy)
      get :teams, to: 'team#index'
      get :oauth, to: 'oauth#index'
      delete '/oauth/:provider', to: 'oauth#delete'
    end
  end

  get '/:team', to: 'app#index'
end
