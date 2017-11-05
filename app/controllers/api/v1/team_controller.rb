class Api::V1::TeamController < Api::V1::ApplicationController
  before_action :authenticate_user!, :authenticate_team!

  def index
    render json: current_user.teams
  end

  def show
    render json: @team
  end
end
