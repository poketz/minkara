class CreateForumComments < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_comments do |t|

      t.timestamps
    end
  end
end
