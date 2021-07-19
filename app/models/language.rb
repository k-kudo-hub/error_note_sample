# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :log_languages, dependent: :destroy
  has_many :logs, through: :log_languages

  def trim
    name.downcase.delete(' ').tr('#', 's').tr('+', 'p').tr('.', 'd')
  end

  def self.rank_with_counts
    joins(:log_languages).group("name").order("count(language_id) desc").limit(5).count
  end

  def self.all_id_and_name
    all.order(id: :asc).pluck(:id, :name)
  end
end
