class User < ApplicationRecord
    has_many :chat_room1s, class_name: 'ChatRoom', foreign_key: 'user1_id'
    has_many :chat_room2s, class_name: 'ChatRoom', foreign_key: 'user2_id'
  end