class CreateForumFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_favorites do |t|

      t.integer :user_id, null: false
      t.integer :forum_id, null: false
      t.timestamps
    end
  end
end
