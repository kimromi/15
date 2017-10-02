class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    identity = Identity.find_or_create_with_omniauth(auth)

    if signed_in?
      unless identity.user == current_user
        identity.user = current_user
        identity.save_with_omniauth!(auth)
      end
      redirect_to app_path, notice: 'Successfully linked that account!'
    else
      unless identity.user.present?
        identity.create_user!(auth)
        identity.save_with_omniauth!(auth)
      end
      sign_in(identity.user)
      redirect_to app_path, notice: 'Signed in!'
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: "Sign out."
  end
end
