# frozen_string_literal: true

class Api::V1::StocksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    stocks = current_user.my_stocks.page(params[:page]).per(10)
    array = []
    array_push(stocks, array)
    total_pages = stocks.total_pages
    response = {
      stocks: array,
      total_pages: total_pages
    }
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
    logs = Log.rank(5)
    counts = Stock.rank(5).count
    array = []
    logs.zip(counts) do |log, count|
      array.push(id: log.id, title: log.title.truncate(9), count: count[1], user_id: log.user_id)
    end
    render json: array
  end

  def check
    log = Log.find(params[:log_id])
    count = log.stocks.count
    if !user_signed_in?
      response = {
        stocked: false,
        count: count
      }
    else
      user = User.find(current_user.id)
      stocked = user.already_stocked?(log)
      response = {
        stocked: stocked,
        count: count
      }
    end
    render json: response
  end

  private

    def array_push(logs, array)
      logs.each do |log|
        languages = []
        log.languages.limit(3).each do |language|
          languages.push(language.name)
        end
        picture = log.user.picture? ? log.user.picture.url : nil
        array.push(
          id: log.id,
          title: log.title,
          languages: languages,
          updated_at: l(log.updated_at, format: :default),
          release: log.release,
          user_id: log.user.id,
          user_name: log.user.name,
          user_picture: picture
        )
      end
      array
    end
end
