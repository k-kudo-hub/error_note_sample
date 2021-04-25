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
    validates :release
  end
end
