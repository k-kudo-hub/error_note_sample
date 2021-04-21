class RemoveEnvironmentToLogs < ActiveRecord::Migration[6.1]
  def up
    remove_column :logs, :environment, :text
  end

  def down
    add_column :logs, :environment, :text
  end
end
