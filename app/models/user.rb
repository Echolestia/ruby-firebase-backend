class User < ApplicationRecord
    has_many :chat_room1s, class_name: 'ChatRoom', foreign_key: 'user1_id', dependent: :destroy
    has_many :chat_room2s, class_name: 'ChatRoom', foreign_key: 'user2_id', dependent: :destroy
    # has_many :messages, dependent: :destroy
    has_secure_password
    validates :email, presence: true, length: { maximum: 255 }

  end