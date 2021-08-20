class AddTwitterColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_index :users, [:uid, :provider], unique: true
  end
end
