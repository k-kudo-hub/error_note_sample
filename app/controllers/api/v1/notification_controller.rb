class Api::V1::NotificationController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    notifications = Notification.some_of_sorted(5)
    render json: notifications
  end

  def show
    notification = Notification.find(params[:id])
    render json: notification
  end

  def show_below_header
    notification = Notification.first_one_of_display_below_header
    render json: notification
  end
end
