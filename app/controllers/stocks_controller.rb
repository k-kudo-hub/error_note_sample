# frozen_string_literal: true

class StocksController < ApplicationController
  def create
    @stock = current_user.stocks.create(log_id: params[:log_id])
    redirect_to user_log_path(current_user, params[:log_id])
  end

  def destroy
    @stock = Stock.find_by(log_id: params[:log_id], user_id: current_user.id)
    @stock.destroy
    redirect_to user_log_path(current_user, params[:log_id])
  end
end
