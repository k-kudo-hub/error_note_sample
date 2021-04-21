module UsersHelper
  def display_languages(languages)
    languages.map(&:name).join(', ')
  end
end
