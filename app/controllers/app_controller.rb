class AppController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.teams.available.where(name: params[:team]).empty?
      redirect_to root_path
    end

    team = current_user.teams.where(name: params[:team]).first
    cookies[:jwt_token] = {
      value: Knock::AuthToken.new(payload: {sub: {user_id: current_user.id, team_id: team.id} }).token,
      secure: Rails.env.production? || Rails.env.staging?,
      expires: 1.day.from_now,
      httponly: true
    }
  end
end
