class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    identity = Identity.find_or_create_with_omniauth(auth)

    if signed_in?
      if identity.user == current_user
        notice = 'Already linked that account!'
      else
        identity.user = current_user
        identity.save_with_omniauth!(auth)
        notice = 'Successfully linked that account!'
      end
    else
      unless identity.user.present?
        identity.create_user!(auth)
        identity.save_with_omniauth!(auth)
      end
      sign_in(identity.user)
      notice = 'Signed in!'
    end

    redirect_to app_path, notice: notice
  end

  def destroy
    sign_out
    redirect_to root_path, notice: "Sign out."
  end
end
