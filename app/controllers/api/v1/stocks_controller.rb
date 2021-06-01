class Api::V1::StocksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def rank
    logs = Log.rank(5)
    counts = Stock.group(:log_id).order('count(log_id) desc').limit(5).count
    array = []
    logs.zip(counts) do |log, count|
      array.push(id: log.id, title: log.title.truncate(9), count: count[1], user_id: log.user_id)
    end
    render json: array
  end

  def check
    user = User.find(params[:user_id])
    log = Log.find(params[:log_id])
    stocked = user.already_stocked?(log)
    count = log.stocks.count
    response = {
      stocked: stocked,
      count: count
    }
    render json: response
  end

end
