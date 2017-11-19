class Api::V1::RecordsController < Api::V1::ApplicationController
  before_action :authenticate_user!, :authenticate_team!
  protect_from_forgery except: :create

  def index
    at = Time.zone.parse(params[:date])
    render json: current_team.records.where(user: current_user, at: [at.beginning_of_day..at.end_of_day])
  end

  def create
    created = current_team.records.create!(create_params.merge(user: current_user))
    render json: created, status: :created
  end

  private

  def create_params
    params.require(:record).permit(:task_id, :at)
  end
end
