# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :logs, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stocked_logs, through: :stocks, source: :log

  with_options presence: { message: 'が入力されていません。' } do
    validates :name
    validates :kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナのみ登録できます。' }
    validates :email
  end

  def already_stocked?(log)
    stocks.exists?(log_id: log.id)
  end
end
