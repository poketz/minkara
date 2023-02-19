class CreateForumComments < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_comments do |t|
      
      t.integer :forum_id, null: false
      t.integer :user_id, null: false
      t.string :comment, null: false
      t.string :audio
      t.timestamps
    end
  end
end
