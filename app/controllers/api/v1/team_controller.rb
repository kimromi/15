class Api::V1::TeamController < Api::V1::ApplicationController
  before_action :authenticate_user!, :authenticate_team!
  protect_from_forgery except: :destroy

  def index
    render json: current_user.teams
  end

  def show
    render json: current_team
  end

  def destroy
    render json: current_team.deleted!, status: :no_content
  end
end
