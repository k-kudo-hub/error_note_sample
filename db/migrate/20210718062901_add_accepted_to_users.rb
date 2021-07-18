class AddAcceptedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :accepted, :boolean, default: false, null: false
  end
end
