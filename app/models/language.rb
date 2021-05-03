class Language < ApplicationRecord
  has_many :log_languages, dependent: :destroy
  has_many :logs, through: :log_languages
  
  def trim
    self.name.downcase.gsub(" ", "").tr("#", 's').tr("+", 'p').tr(".", 'd')
  end
end
