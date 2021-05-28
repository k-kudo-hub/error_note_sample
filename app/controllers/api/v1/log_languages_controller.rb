class Api::V1::LogLanguagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def create
    log = Log.find(log_language_params[:log])
    language = Language.find(log_language_params[:language])
    log_language = LogLanguage.new(log: log, language: language)
    if log_language.save
      head :no_content
    else
      render json: log_language.errors, status: :unprocessable_entity
    end
  end

  private

  def before_save(params)
    
    
  end

  def log_language_params
    params.require(:log_language).permit(:language, :log)
  end
end
