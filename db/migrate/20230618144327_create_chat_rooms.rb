class CreateChatRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_rooms do |t|
      t.float :overall_sentiment_analysis_score
      t.datetime :date_created
      t.boolean :is_ai_chat
      t.boolean :is_group_chat
      t.references :user1, foreign_key: { to_table: :users }
      t.references :user2, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
