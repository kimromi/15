class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def sign_in(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end

  def sign_out
    @current_user = nil
    session[:user_id] = nil
  end

  def authenticate_user!
    redirect_to root_path unless signed_in?
  end
end
