class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|

      t.references :subject, null: false, polymorphic: true
      t.integer :user_id, null: false
      t.integer :action, null: false, default: 0
      t.boolean :read, null: false, default: false
      t.timestamps
    end
  end
end
