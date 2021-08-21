# frozen_string_literal: true

class Notification < ApplicationRecord
  with_options presence: { message: 'が入力されていません。' } do
    validates :title
    validates :content
  end
  validates :is_important, inclusion: { in: [true, false] }
  validates :below_header, inclusion: { in: [true, false] }
end
