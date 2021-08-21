class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title,          null: false
      t.text :content,          null: false
      t.boolean :is_important,  null: false, default: false
      t.boolean :below_header,  null: false, default: false
      t.timestamps
    end
  end
end
