# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :picture, PictureUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:twitter]
  has_many :logs, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stocked_logs, through: :stocks, source: :log

  validates :name, presence: { message: 'が入力されていません。' }
  validates :accepted, presence: { message: 'いただけない場合、アカウントを作成できません。' }, on: :create

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        name:     auth.info.name,
        accepted: true,
        confirmation_token: Devise.friendly_token[0, 20],
        confirmed_at: Time.current
      )
    end
    user
  end

  def already_stocked?(log)
    stocks.exists?(log_id: log.id)
  end

  def my_stocks
    Log.where(id: stock_ids).where(release: true).order(created_at: :desc)
  end

  def picture_url
    picture? ? picture.url : nil
  end

  def stock_ids
    stocks.pluck(:log_id)
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
