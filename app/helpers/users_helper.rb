# frozen_string_literal: true

module UsersHelper
  def display_languages(languages)
    languages.map(&:name).join(', ')
  end

  def display_release(release)
    if release == true
      '公開'
    else
      '非公開'
    end
  end
end
