# frozen_string_literal: true

class AddTitleToLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :logs, :title, :string, null: false
  end
end
