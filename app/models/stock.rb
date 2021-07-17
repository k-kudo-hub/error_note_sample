# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :log
  belongs_to :user
  validates :log_id, uniqueness: { scope: :user_id }
  validate :self_stock_validation

  def self_stock_validation
    errors.add(:user_id, '：自分で作成したノートはストックできません') if log.user_id == user.id
  end

  def self.rank(limit)
    group(:log_id).order('count(log_id) desc').limit(limit)
  end
end
