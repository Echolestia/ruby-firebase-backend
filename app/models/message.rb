class Message < ApplicationRecord
  belongs_to :chat_room
  validates :content, presence: true, length: { minimum: 1,maximum: 35555 }

end
