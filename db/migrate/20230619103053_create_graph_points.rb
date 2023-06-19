class CreateGraphPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :graph_points do |t|
      t.float :x
      t.float :y
      t.references :chat_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
