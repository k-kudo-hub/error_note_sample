# frozen_string_literal: true

class Api::V1::LanguagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    languages = Language.all_id_and_name
    render json: languages
  end

  def rank
    object = Language.rank_with_counts(5)
    array = []
    object.each do |obj|
      array.push(name: obj[0], count: obj[1])
    end
    render json: array
  end
end
