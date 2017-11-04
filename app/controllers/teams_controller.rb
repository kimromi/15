class TeamsController < ApplicationController
  def new
    @team = Team.new
    if signed_in?
      @teams = current_user.teams
    end
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

  def create_params
    params.require(:team).permit(:name)
  end
end
