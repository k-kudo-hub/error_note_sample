# frozen_string_literal: true

class LogsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :find_log, only: %i[show edit update]

  def index
    @logs = Log.where(release: true).includes(:user, :languages).order('updated_at DESC').page(params[:page]).per(10)
    @top_lang = Language.rank
  end

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

  def show
    @stock = Stock.new
  end

  def edit; end

  def update
    if @log.update(log_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    log = Log.find(params[:id])
    log.destroy
    redirect_to user_path(current_user)
  end

  def search
    @logs = Log.search(params[:keyword]).page(params[:page]).per(10)
  end

  private

    def log_params
      params.require(:log).permit(:title, :error, :solution, :release,
                                  { language_ids: [] }).merge(user_id: current_user.id)
    end

    def find_log
      @log = Log.find(params[:id])
    end
end
