class InvitationsController < ApplicationController
  def show
    @invitation = Invitation.find_by_token(params[:token])
    unless @invitation
      render file: 'public/404.html', status: 404, layout: false, content_type: 'text/html'
      return
    end

    if signed_in? && @invitation.team.members.pluck(:user_id).include?(current_user.id)
      redirect_to "/#{@invitation.team.name}", alert: "Already join #{@invitation.team.name} team."
    end

    session[:invitation_id] = @invitation.id
    @team = @invitation.team
  end

  def update
    @invitation = Invitation.find_by_token(invitation_params[:token])
    redirect_to root_path, notice: "Join #{@invitation.team.name} team!!"
    redirect_to "/#{@invitation.team.name}", notice: "Join #{@invitation.team.name} team!!"
  end

  private

  def invitation_params
    params.require(:invitation).permit(:token)
  end
end
