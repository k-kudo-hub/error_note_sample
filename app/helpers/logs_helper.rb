# frozen_string_literal: true

module LogsHelper
  def display_languages(languages)
    languages.map(&:name).join(', ')
  end
end
