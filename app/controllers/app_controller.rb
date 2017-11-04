class AppController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.teams.where(name: params[:team]).empty?
      redirect_to root_path
    end
  end
end
