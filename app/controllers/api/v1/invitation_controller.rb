class Api::V1::InvitationController < Api::V1::ApplicationController
  before_action :authenticate_user!, :authenticate_team!

  def index
    render json: current_team.current_invitaion
  end
end
