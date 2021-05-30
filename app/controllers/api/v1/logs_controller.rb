class Api::V1::LogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    logs = Log.where(release: true).includes(:user, :languages).order('updated_at DESC').page(params[:page]).per(10)
    array = []
    array_push(logs, array)
    total_pages = logs.total_pages
    response = {
      logs: array,
      total_pages: total_pages
    }
    render json: response
  end

  def latest_stocks
    logs = current_user.my_stocks.page(params[:page]).per(10)
    array = []
    array_push(logs, array)
    total_pages = logs.total_pages
    response = {
      logs: array,
      total_pages: total_pages
    }
    render json: response
  end

  def most_stocked_logs
    logs = Log.rank(10)
    array = []
    array_push(logs, array)
    response = {
      logs: array,
      total_pages: 1
    }
    render json: response
  end 

  def create
    log = Log.new(log_params)
    if log.save
      log_info = {id: log.id, user_id: current_user.id}
      render json: log_info
    else
      render json: log.errors, status: :unprocessable_entity
    end
  end

  def search
    logs = Log.search(params[:keyword]).page(params[:page]).per(params[:per])
    array = []
    array_push(logs, array)
    total_pages = logs.total_pages
    response = {
      logs: array,
      total_pages: total_pages
    }
    render json: response
  end

  private

  def log_params
    params.require(:log).permit(:title, :error, :solution, :release).merge(user_id: current_user.id)
  end

  def array_push(logs, array)
    logs.each do |log|
      languages = []
      log.languages.limit(3).each do |language|
        languages.push(language.name)
      end
      picture = log.user.picture? ? log.user.picture.url : nil
      array.push(
        id: log.id,
        title: log.title,
        languages: languages,
        updated_at:l(log.updated_at, format: :default),
        release: log.release,
        user_id: log.user.id,
        user_name: log.user.name,
        user_picture: picture,
      )
    end
    return array
  end

end
