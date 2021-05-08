# frozen_string_literal: true

class CreateLogLanguages < ActiveRecord::Migration[6.1]
  def change
    create_table :log_languages do |t|
      t.references :log, foreign_key: true
      t.references :language, foreign_key: true
      t.timestamps
    end
  end
end
