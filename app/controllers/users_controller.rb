class UsersController < ApplicationController

  def index
  end
  
  def show
    @user = User.find(params[:id])
    @logs = @user.logs.all.includes(:user).order('updated_at DESC')
  end

end
