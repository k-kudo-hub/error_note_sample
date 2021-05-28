class Api::V1::LogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def create
    log = Log.new(log_params)
    if log.save
      render json: log.id
    else
      render json: log.errors, status: :unprocessable_entity
    end
  end

  private

  def log_params
    params.require(:log).permit(:title, :error, :solution, :release).merge(user_id: current_user.id)
  end

end
