# frozen_string_literal: true

class Api::V1::LogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    logs = Log.published_all.page(params[:page]).per(10)
    array = Array.new
    shape_object(logs, array)
    total_pages = logs.total_pages
    response = { logs: array, total_pages: total_pages }
    render json: response
  end

  def latest_stocks_index
    logs = current_user.my_stocks.page(params[:page]).per(10)
    array = Array.new
    shape_object(logs, array)
    total_pages = logs.total_pages
    response = { logs: array, total_pages: total_pages }
    render json: response
  end

  def most_stocked_index
    logs = Log.rank(10)
    array = Array.new
    shape_object(logs, array)
    response = { logs: array, total_pages: 1 }
    render json: response
  end

  def create
    log = Log.new(log_params)
    if log.save
      log_info = { id: log.id, user_id: current_user.id }
      render json: log_info
    else
      render json: log.errors, status: :unprocessable_entity
    end
  end

  def show
    log = Log.find(params[:id])
    languages = log.extract_lang_data
    user = { 
             id: log.user_id,
             name: log.user.name, 
             picture: log.user.picture_url, 
             introduce: log.user.introduce
            }
    log = {
            id: log.id,
            title: log.title, 
            error: log.error, 
            solution: log.solution, 
            release: log.release,
            updated_at: l(log.updated_at, format: :default) 
          }
    response = { log: log, languages: languages, user: user }
    render json: response
  end

  def update
    log = Log.find(params[:log][:id])
    if log.update(
      title: params[:log][:title],
      error: params[:log][:error],
      solution: params[:log][:solution],
      release: params[:log][:release],
      language_ids: params[:languages]
    )
      log_info = { id: log.id, user_id: current_user.id }
      render json: log_info
    else
      render json: log.errors, status: :unprocessable_entity
    end
  end

  def destroy
    log = Log.find(params[:id])
    user_id = log.user_id
    if log.destroy
      render json: user_id
    else
      render json: log.errors, status: :unprocessable_entity
    end
  end

  def search
    logs = Log.search(params[:keyword]).page(params[:page]).per(params[:per])
    array = Array.new
    shape_object(logs, array)
    total_pages = logs.total_pages
    response = {
      logs: array,
      total_pages: total_pages
    }
    render json: response
  end

  private

    def log_params
      params.require(:log).permit(:title, :error, :solution, :release, { language_ids: [] }).merge(user_id: current_user.id)
    end

    def shape_object(logs, array)
      logs.each do |log|
        array.push(
          id: log.id,
          title: log.title,
          languages: log.extract_lang_name,
          updated_at: l(log.updated_at, format: :default),
          release: log.release,
          user_id: log.user.id,
          user_name: log.user.name,
          user_picture: log.user.picture_url
        )
      end
      array
    end
end
