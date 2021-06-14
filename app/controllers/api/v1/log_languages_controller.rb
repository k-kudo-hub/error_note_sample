# frozen_string_literal: true

class Api::V1::LogLanguagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end
end
