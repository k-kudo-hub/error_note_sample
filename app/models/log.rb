# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :user
  has_many :log_languages, dependent: :destroy
  has_many :languages, through: :log_languages
  has_many :stocks, dependent: :destroy
  has_many :stocked_users, through: :stocks, source: :user

  with_options presence: { message: 'が入力されていません。' } do
    validates :title
    validates :error
  end

  validates :release, inclusion: { in: [true, false] }

  scope :group_by_id, -> { 
    group('log_id')
  }

  scope :limited, -> (count) {
    limit(count)
  }

  scope :published, -> {
    where(release: true)
  }

  scope :rank, -> {
    order('count(log_id) DESC')
  }

  scope :searched, -> (keyword) {
    where('title LIKE(?)', "%#{keyword}%")
  }

  scope :select_for_rank, -> {
    select('logs.id, logs.title, logs.user_id, count(log_id) AS count')
  }

  scope :sorted, -> {
    order(updated_at: :desc)
  }

  scope :with_stocks, -> {
    joins(:stocks)
  }

  scope :with_user_and_langs, -> {
    includes(:user, :languages)
  }

  scope :published_all, -> {
     published.with_user_and_langs.sorted 
  }

  scope :stock_rank, -> (count) {
    with_stocks.group_by_id.rank.limited(count)
  }

  scope :stock_rank_with_counts, -> (count) {
     with_stocks.group_by_id.rank.select_for_rank.limited(count)
  }

  scope :search, -> (keyword) {
    if keyword.empty?
      published.with_user_and_langs.sorted
    else
      searched(keyword).published.with_user_and_langs.sorted
    end
  }

  def extract_lang_data
    languages = []
    self.languages.each do |lang|
      languages.push(id: lang.id, name: lang.name)
    end
    languages
  end

  def extract_lang_name
    languages.limit(3).map(&:name)
  end
end
