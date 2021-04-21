class ReplaceLogsColumns < ActiveRecord::Migration[6.1]
  def up
    remove_column :logs, :memo, :text
  end

  def down
    add_column :logs, :memo, :text
  end
end
