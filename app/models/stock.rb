# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :log
  belongs_to :user
  validates :log_id, uniqueness: { scope: :user_id }

  def self.rank(limit)
    group(:log_id).order('count(log_id) desc').limit(limit)
  end
end
