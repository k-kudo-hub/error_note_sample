# frozen_string_literal: true

class InsertInitialLanguage < ActiveRecord::Migration[6.1]
  def change
    languages = %w[Python Ruby PHP]
    languages.each do |language|
      Language.create(name: language)
    end
  end
end
