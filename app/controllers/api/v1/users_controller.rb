# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def authentication
    if user_signed_in?
      picture = current_user.picture_url
      user = { auth: true, id: current_user.id, picture: picture }
    else
      user = { auth: false, id: nil, picture: nil }
    end
    render json: user
  end

  def show
    user = User.find(params[:user_id])
    picture = user.picture_url
    user = { id: user.id, name: user.name, picture: picture, introduce: user.introduce }
    render json: user
  end

  def user_log_index
    user = User.find(params[:user_id])
    logs = if user_signed_in? && (user.id == current_user.id)
             user.all_logs.page(params[:page]).per(10)
           else
             user.published_log.page(params[:page]).per(10)
           end
    array = shape_object(logs)
    response = { logs: array, total_pages: logs.total_pages }
    render json: response
  end

  private

    def shape_object(logs)
      array = []
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
