class TeamsController < ApplicationController
  before_action :fetch_teams

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(create_params)
    if @team.valid?
      if signed_in?
        @team.save
        @team.members.create(user_id: current_user.id)
        redirect_to root_path
      else
        session[:team] = @team
        redirect_to new_session_path
      end
    else
      render :new
    end
  end

  private

  def fetch_teams
    @teams = current_user.teams.available if signed_in?
  end

  def create_params
    params.require(:team).permit(:name)
  end
end
