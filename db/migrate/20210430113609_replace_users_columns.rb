class ReplaceUsersColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :kana, :string
    add_column :users, :introduce, :string
    add_column :users, :picture, :string
  end
end
