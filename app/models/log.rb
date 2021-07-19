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

  def self.published_all
    where(release: true).includes(:user, :languages).order(updated_at: :desc)
  end

  def self.search(keyword)
    if keyword.empty?
      Log.where(release: true).includes(:user, :languages).order(updated_at: :desc)
    else
      Log.where('title LIKE(?)', "%#{keyword}%").where(release: true).includes(:user, :languages).order(updated_at: :desc)
    end
  end

  def self.rank(limit)
    joins(:stocks).group("log_id").order("count(log_id) DESC").limit(limit)
  end

  def self.stock_rank_with_counts 
    joins(:stocks).group("log_id").order("count(log_id) DESC").select("logs.id, logs.title, logs.user_id, count(log_id) AS count").limit(5)
  end

  def extract_lang_name
    languages = Array.new
    self.languages.each do |lang|
      languages.push(lang.name)
    end
    languages
  end

  def extract_lang_data
    languages = Array.new
    self.languages.each do |lang|
      languages.push(id: lang.id, name: lang.name)
    end
    languages
  end

end
