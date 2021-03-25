class LogsController < ApplicationController
  def index
    @logs = Log.all.includes(:user).first(10)
  end

  def new
    @log = Log.new(params[:id])
  end

  def create
    @log = Log.new(log_params)
    if @log.valid?
      @log.save
      render "logs/create"
    else
      render :new
    end
  end

  def show
    @log = Log.find(params[:id])
  end

  private

  def log_params
    params.require(:log).permit(:title, :error, :solution, :memo, :language, :release).merge(user_id: current_user.id)
  end
end
