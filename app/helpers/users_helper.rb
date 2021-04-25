# frozen_string_literal: true

module UsersHelper
  def display_languages(languages)
    languages.map(&:name).join(', ')
  end
end
