# frozen_string_literal: true

class RemoveLanguageToLogs < ActiveRecord::Migration[6.1]
  def up
    remove_column :logs, :language, :integer
  end

  def down
    add_column :logs, :language, :integer
  end
end
