# frozen_string_literal: true

class Notification < ApplicationRecord
  with_options presence: { message: 'が入力されていません。' } do
    validates :title
    validates :content
  end
  validates :is_important, inclusion: { in: [true, false] }
  validates :below_header, inclusion: { in: [true, false] }
  
  scope :first_one_of_display_below_header, -> {
    where(below_header: true).sorted.first
  }
  
  scope :limited, ->(count) {
    limit(count)
  }

  scope :some_of_sorted, ->(count = 5) {
    limited(count).sorted
  }

  scope :sorted, -> {
    order(updated_at: :desc)
  }
end
