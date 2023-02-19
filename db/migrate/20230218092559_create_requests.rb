class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|

      t.integer :requester_id, null: false
      t.integer :requested_id, null: false
      t.integer :song_id, null: false
      t.timestamps
    end
  end
end
