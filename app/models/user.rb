# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :picture, PictureUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :logs, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stocked_logs, through: :stocks, source: :log

  validates :name, presence: { message: 'が入力されていません。' }
  validates :accepted, presence: { message: 'いただけない場合、アカウントを作成できません。' }, on: :create

  def already_stocked?(log)
    stocks.exists?(log_id: log.id)
  end

  def stock_ids
    Stock.where(user_id: id).pluck(:log_id)
  end

  def my_stocks
    Log.where(id: stock_ids).order(created_at: :desc)
  end

  def picture_url
    picture? ? picture.url : nil
  end

  def all_logs
    self.logs.includes(:user, :languages).order(updated_at: :desc)
  end

  def published_log
    self.logs.where(release: true).includes(:user, :languages).order(updated_at: :desc)
  end
end
