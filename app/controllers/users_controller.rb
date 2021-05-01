class UsersController < ApplicationController

  def index
  end
  
  def show
    @user = User.find(params[:id])
    @logs = @user.logs.all.includes(:user).order(updated_at: :desc).page(params[:page]).per(10)
    @stocks = @user.my_stocks.page(params[:page]).per(10)
  end

end
