# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :log_languages, dependent: :destroy
  has_many :logs, through: :log_languages

  scope :all_id_and_name, -> {
    id_and_name.sort_by_id
  }
  
  scope :group_by_name, -> {
    group('name')
  }
  
  scope :id_and_name, -> {
    select(:id, :name)
  }
  
  scope :sort_by_lang_count, -> {
    order('count(language_id) desc')
  }
  
  scope :limited, ->(count) {
    limit(count)
  }

  scope :rank_with_counts, ->(count) {
    with_log_langs.group_by_name.sort_by_lang_count.limited(count).count
  }

  scope :sort_by_id, -> {
    order(id: :asc)
  }
  
  scope :with_log_langs, -> {
    joins(:log_languages)
  }

  def trim
    name.downcase.delete(' ').tr('#', 's').tr('+', 'p').tr('.', 'd')
  end
end
