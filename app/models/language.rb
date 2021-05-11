# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :log_languages, dependent: :destroy
  has_many :logs, through: :log_languages

  def trim
    name.downcase.delete(' ').tr('#', 's').tr('+', 'p').tr('.', 'd')
  end

  def self.rank
    find(LogLanguage.group(:language_id).order('count(language_id) desc').limit(5).pluck(:language_id))
  end

  def rank_count
    LogLanguage.where(language_id: id).count
  end
end
