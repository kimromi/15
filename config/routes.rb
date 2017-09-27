Rails.application.routes.draw do
  root 'top#index'
  get 'top/index'

  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
end
