class Api::V1::OauthController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery except: :delete

  def index
    render json: current_user.identities
  end

  def delete
    if Identity.providers.keys.include?(params['provider'])
      current_user.identities.send(params['provider']).first.destroy
      render json: nil, status: :no_content
    else
      render json: 'invalid provider', status: :bad_request
    end
  end
end
