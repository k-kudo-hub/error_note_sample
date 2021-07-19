# frozen_string_literal: true

class Api::V1::StocksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    stocks = current_user.my_stocks.page(params[:page]).per(10)
    array_push(stocks, array)
    array = Array.new
    total_pages = stocks.total_pages
    response = { stocks: array, total_pages: total_pages }
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
    object = Log.stock_rank_with_counts
    array = Array.new
    object.each do |obj|
      array.push(id: obj.id, title: obj.title, count: obj.count, user_id: obj.user_id)
    end
    render json: array
  end

  def check
    log = Log.find(params[:log_id])
    count = log.stocks.count
    if user_signed_in?
      stocked = current_user.already_stocked?(log)
      response = { stocked: stocked, count: count }
    else
      response = { stocked: false, count: count }
    end
    render json: response
  end

  private

    def array_push(logs, array)
      logs.each do |log|
        array.push(
          id: log.id,
          title: log.title,
          languages: log.extract_lang_name,
          updated_at: l(log.updated_at, format: :default),
          release: log.release,
          user_id: log.user.id,
          user_name: log.user.name,
          user_picture: log.user.picture_url
        )
      end
      array
    end
end
