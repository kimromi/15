class Api::V1::ApplicationController < ApplicationController
  def authenticate_team!
    payload = Knock::AuthToken.new(token: request.cookies['jwt_token']).payload['sub']

    unless @team = current_user.teams.find(payload['team_id'])
      render json: { message: 'invalid team' }, status: :bad_request
    end
  end
end
