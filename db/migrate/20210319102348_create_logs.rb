# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.references :user,   null: false, foreign_key: true
      t.text :error,        null: false
      t.text :solution
      t.text :environment
      t.text :memo
      t.integer :language
      t.boolean :release

      t.timestamps
    end
  end
end
