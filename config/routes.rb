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
      delete :team, to: 'team#destroy'

      resources :tasks, only: %i(index create update)
      get :oauth, to: 'oauth#index'
      delete '/oauth/:provider', to: 'oauth#delete'

      resources :members, only: %i(index)
      get :invitation, to: 'invitation#index'
    end
  end

  get '/:team', to: 'app#index'
  resources :invitations, param: :token, only: %i(show update)
  get 'members/invitation/:token', to: 'invitations#show'
end
