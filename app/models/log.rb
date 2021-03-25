class Log < ApplicationRecord
  belongs_to :user
  with_options presence: { message: 'が入力されていません。'} do 
    validates :title
    validates :error
    validates :release
  end
end
