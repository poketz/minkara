class CreateForumFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_favorites do |t|

      t.timestamps
    end
  end
end
