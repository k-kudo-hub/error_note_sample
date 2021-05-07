# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :picture, PictureUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :logs
  has_many :stocks, dependent: :destroy
  has_many :stocked_logs, through: :stocks, source: :log

  with_options presence: { message: 'が入力されていません。' } do
    validates :name
  end

  def already_stocked?(log)
    stocks.exists?(log_id: log.id)
  end

  def stock_ids
    Stock.where(user_id: id).pluck(:log_id)
  end

  def my_stocks
    Log.where(id: stock_ids).order(created_at: :desc)
  end
end
