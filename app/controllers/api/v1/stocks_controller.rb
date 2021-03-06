# frozen_string_literal: true

class Api::V1::StocksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    stocks = current_user.my_stocks.page(params[:page]).per(10)
    array = shape_object(stocks)
    response = { stocks: array, total_pages: stocks.total_pages }
    render json: response
  end

  def create
    stock = current_user.stocks.create!(log_id: params[:log_id])
    render json: stock, status: :created
  end

  def destroy
    stock = Stock.find_by(log_id: params[:log_id], user_id: current_user.id)
    stock.destroy!
    head :no_content
  end

  def rank
    object = Log.stock_rank_with_counts(5)
    render json: object
  end

  def check
    log = Log.find(params[:log_id])
    count = log.stocks.count
    stocked = if user_signed_in?
                current_user.already_stocked?(log)
              else
                false
              end
    response = { stocked: stocked, count: count }
    render json: response
  end
end
