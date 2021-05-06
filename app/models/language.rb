# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :log_languages, dependent: :destroy
  has_many :logs, through: :log_languages
end
