class Api::V1::MembersController < Api::V1::ApplicationController
  before_action :authenticate_user!, :authenticate_team!

  def index
    render json: current_team.members
  end
end
