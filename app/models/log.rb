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

  def self.search(keyword)
    if keyword.empty?
      Log.where(release: true).includes(:user, :languages).order('updated_at DESC')
    else
      Log.where('title LIKE(?)', "%#{keyword}%").where(release: true).includes(:user, :languages).order('updated_at DESC')
    end
  end

  def self.rank(limit)
    self.find(Stock.group(:log_id).order('count(log_id) desc').limit(limit).pluck(:id))
  end
end
