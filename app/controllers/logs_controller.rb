class LogsController < ApplicationController
  before_action :find_log, only: [:show, :edit, :update]

  def index
    @logs = Log.all.includes(:user).order('updated_at DESC').first(10)
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

  private

  def log_params
    params.require(:log).permit(:title, :error, :solution, :release, {language_ids: []}).merge(user_id: current_user.id)
  end

  def find_log
    @log = Log.find(params[:id])
  end
end
