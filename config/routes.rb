Rails.application.routes.draw do
  root 'app#index'
  get 'app/index'

  get '/auth/:provider/callback', to: 'sessions#create'

  get '/signout', to: 'sessions#destroy'

  namespace :api, { format: :json } do
    namespace :v1 do
      get 'oauth', to: 'oauth#index'
      delete '/oauth/:provider', to: 'oauth#delete'
    end
  end
end
