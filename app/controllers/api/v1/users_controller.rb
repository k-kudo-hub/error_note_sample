# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def authentication
    if user_signed_in?
      picture = current_user.picture? ? current_user.picture.url : nil
      user = { auth: true, id: current_user.id, picture: picture }
    else
      user = { auth: false, id: nil, picture: nil }
    end
    render json: user
  end

  def show
    user = User.find(params[:user_id])
    picture = user.picture? ? user.picture.url : nil
    user = { id: user.id, name: user.name, picture: picture, introduce: user.introduce }
    render json: user
  end

  def user_log_index
    @user = User.find(params[:user_id])
    logs = published_log.order(updated_at: :desc).page(params[:page]).per(10)
    array_push(logs, array)
    array = Array.new
    total_pages = logs.total_pages
    response = { logs: array, total_pages: total_pages }
    render json: response
  end

  private

    def published_log
      if user_signed_in? && (@user.id == current_user.id)
        @user.logs.all.includes(:user, :languages)
      else
        @user.logs.where(release: true).includes(:user, :languages)
      end
    end

    def array_push(logs, array)
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
