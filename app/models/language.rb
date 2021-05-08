# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :log_languages, dependent: :destroy
  has_many :logs, through: :log_languages

  def trim
    name.downcase.delete(' ').tr('#', 's').tr('+', 'p').tr('.', 'd')
  end
end
