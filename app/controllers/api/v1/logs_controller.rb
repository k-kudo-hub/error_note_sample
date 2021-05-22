class Api::V1::LogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def languages
    top_lang = Language.rank
    render json: top_lang
  end

  def count_languages
    logs = LogLanguage.group(:language_id).order('count(language_id) desc').limit(5).count
    array = []
    logs.each do |log|
      array << log[1]
    end
    render json: array
  end

  def stocks
    top_log = Log.rank
    render json: top_log
  end

  def count_stocks
    logs = Stock.group(:log_id).order('count(log_id) desc').limit(5).count
    array = []
    logs.each do |log|
      array << log[1]
    end
    render json: array
  end

end
