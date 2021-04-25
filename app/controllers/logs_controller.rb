# frozen_string_literal: true

class LogsController < ApplicationController
  def index
    @logs = Log.all.includes(:user).order('updated_at DESC').first(10)
  end

  def new
    @log = Log.new(params[:id])
  end

  def create
    @log = Log.new(log_params)
    if @log.valid?
      @log.save
      render 'logs/create'
    else
      render :new
    end
  end

  def show
    @log = Log.find(params[:id])
    @stock = Stock.new
  end

  def edit
    @log = Log.find(params[:id])
  end

  def update
    @log = Log.find(params[:id])
    if @log.valid?
      @log.update(log_params)
      render 'logs/update'
    else
      render :edit
    end
  end

  private

    def log_params
      params.require(:log).permit(:title, :error, :solution, :release, { language_ids: [] }).merge(user_id: current_user.id)
    end
end
