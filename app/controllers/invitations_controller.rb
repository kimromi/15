class InvitationsController < ApplicationController
  def show
    @invitation = Invitation.find_by_token(params[:token])
    unless @invitation
      render file: 'public/404.html', status: 404, layout: false, content_type: 'text/html'
      return
    end

    redirect_to_app_if_already_joined(@invitation)

    session[:invitation_id] = @invitation.id
    @team = @invitation.team
  end

  def update
    binding.pry
    @invitation = Invitation.find_by_token(invitation_params[:token])
    redirect_to_app_if_already_joined(@invitation)
    @invitation.team.members.create(user_id: current_user.id)

    redirect_to "/#{@invitation.team.name}", notice: "Join #{@invitation.team.name} team!!"
  end

  private

  def invitation_params
    params.require(:invitation).permit(:token)
  end

  def redirect_to_app_if_already_joined(invitation)
    if signed_in? && invitation.team.members.pluck(:user_id).include?(current_user.id)
      redirect_to "/#{invitation.team.name}", alert: "Already join #{invitation.team.name} team."
    end
  end
end
