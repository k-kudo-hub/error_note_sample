class Api::V1::LanguagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    languages = Language.all.order(id: :asc).pluck(:id, :name)
    array = []
    languages.each do |language|
      array.push(id: language[0], name: language[1])
    end
    render json: array
  end

  def rank
    langs = Language.rank
    counts = LogLanguage.group(:language_id).order('count(language_id) desc').limit(5).count
    array = []
    langs.zip(counts) do |lang, count|
      array.push(name: lang.name, count: count[1])
    end
    render json: array
  end

end
