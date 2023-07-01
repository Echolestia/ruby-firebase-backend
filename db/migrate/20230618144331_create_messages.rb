class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.datetime :timestamp
      t.float :sentiment_analysis_score
      t.text :content
      t.string :message_type
      t.references :chat_room, null: false, foreign_key: true
      t.boolean :read
      t.timestamps
    end
  end
end
