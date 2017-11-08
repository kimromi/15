class Api::V1::ApplicationController < ApplicationController
  def authenticate_team!
    unless current_team
      render json: { message: 'invalid team' }, status: :bad_request
    end
  end

  def current_team
    @current_team ||= current_user.teams.find(team_id)
  end

  private

  def team_id
    Knock::AuthToken.new(token: request.cookies['jwt_token']).payload['sub']['team_id']
  end

end
