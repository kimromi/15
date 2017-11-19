class Api::V1::TasksController < Api::V1::ApplicationController
  before_action :authenticate_user!, :authenticate_team!
  protect_from_forgery except: :create

  def index
    render json: current_team.tasks.undeleted
  end

  def create
    unless current_team.tasks.pluck(:name).include?(create_params[:name])
      render json: current_team.tasks.create!(create_params), status: :created
    else
      render json: { message: 'Task already created' }, status: :bad_request
    end
  end

  def update
    task = current_team.tasks.find(params[:id])
    render json: task.update_attributes!(update_params), status: :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Task not found' }, status: :not_found
  end

  private

  def create_params
    params.require(:task).permit(:name)
  end

  def update_params
    params.require(:task).permit(:background_color, :deleted)
  end
end
