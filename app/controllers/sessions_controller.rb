class SessionsController < ApplicationController
  after_action :clear_session, only: %i(create destroy)

  def create
    auth = request.env['omniauth.auth']
    identity = Identity.find_or_create_with_omniauth(auth)

    if signed_in?
      unless identity.user == current_user
        identity.user = current_user
        identity.save_with_omniauth!(auth)
      end
      redirect_to root_path, notice: 'Successfully linked that account!'
    else
      unless identity.user.present?
        identity.create_user_with_omniauth!(auth)
        identity.save_with_omniauth!(auth)
      end

      sign_in(identity.user)

      if session[:team]
        team = Team.new(session[:team])
        team.save
        team.members.create(user_id: current_user.id)
        session[:team] = nil
      end

      if session[:invitation_id]
        invitation = Invitation.find(session[:invitation_id])
        if invitation.team.members.pluck(:user_id).include?(current_user.id)
          message = { alert: "Already join #{invitation.team.name} team." }
        else
          invitation.team.members.create(user_id: current_user.id)
          message = { notice: "Signed in and Join #{invitation.team.name} team!" }
        end
        session[:invitation_id] = nil
        redirect_to "/#{invitation.team.name}", message and return
      end

      redirect_to root_path, notice: message || 'Signed in!'
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: "Sign out."
  end

  private

  def clear_session
    session[:team] = nil
    session[:invitation_id] = nil
  end
end
