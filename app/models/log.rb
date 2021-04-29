class Log < ApplicationRecord
  belongs_to :user
  has_many :log_languages, dependent: :destroy
  has_many :languages, through: :log_languages
  has_many :stocks, dependent: :destroy
  has_many :stocked_users, through: :stocks, source: :user

  with_options presence: { message: 'が入力されていません。'} do 
    validates :title
    validates :error
  end

  def self.search(keyword)
    logs = if keyword.empty?
             Log.all
           else
             Log.where('title LIKE(?)', "%#{keyword}%")
           end
  end
end
