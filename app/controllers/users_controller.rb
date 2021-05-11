# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @logs = published_log.order(updated_at: :desc).page(params[:page]).per(10)
    @stocks = @user.my_stocks.page(params[:page]).per(10)
  end

  private

    def published_log
      if user_signed_in? && (@user.id == current_user.id)
        @user.logs.all.includes(:user, :languages)
      else
        @user.logs.where(release: true).includes(:user, :languages)
      end
    end
end
