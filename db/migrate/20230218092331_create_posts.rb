class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :song_id
      t.string :audio, null: false
      t.string :poster_comment
      t.integer :open_range, null: false, default: 0
      t.timestamps
    end
  end
end
