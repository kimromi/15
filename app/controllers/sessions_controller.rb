class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    identity = Identity.find_or_create_with_omniauth(auth)

    if identity.user.present?
      sign_in(identity.user)
    else
      identity.save!
      identity.create_user!(
        name: auth['info']['nickname']
      )
    end
    redirect_to app_path, notice: "Signed in!"
  end

  def destroy
    sign_out
    redirect_to root_path, notice: "Sign out."
  end
end
