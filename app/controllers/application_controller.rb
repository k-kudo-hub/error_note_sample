# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: %i[name email introduce picture password password_confirmation accepted])
      devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name email introduce picture])
    end

    def shape_object(logs)
      array = []
      logs.each do |log|
        array.push(
          id: log.id, title: log.title, languages: log.extract_lang_name, updated_at: l(log.updated_at, format: :default),
          release: log.release, user_id: log.user.id, user_name: log.user.name, user_picture: log.user.picture_url
        )
      end
      array
    end
end
