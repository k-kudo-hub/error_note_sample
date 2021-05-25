class Api::V1::LogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def lang_count
    langs = Language.rank
    counts = LogLanguage.group(:language_id).order('count(language_id) desc').limit(5).count
    array = []
    langs.zip(counts) do |lang, count|
      array.push(name: lang.name, count: count[1])
    end
    render json: array
  end

  def stock_count
    logs = Log.rank
    counts = Stock.group(:log_id).order('count(log_id) desc').limit(5).count
    array = []
    logs.zip(counts) do |log, count|
      array.push(id: log.id, title: log.title, count: count[1], user_id: log.user_id)
    end
    render json: array
  end

end
