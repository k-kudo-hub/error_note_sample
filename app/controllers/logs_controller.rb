# frozen_string_literal: true

class LogsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def new
    @log = Log.new(params[:id])
  end

  def create
    @log = Log.new(log_params)
    if @log.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def search
    @logs = Log.search(params[:keyword]).page(params[:page]).per(10)
  end

  private

    def log_params
      params.require(:log).permit(:title, :error, :solution, :release,
                                  { language_ids: [] }).merge(user_id: current_user.id)
    end
end
