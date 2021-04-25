# frozen_string_literal: true

class LogLanguage < ApplicationRecord
  belongs_to :log
  belongs_to :language
end
