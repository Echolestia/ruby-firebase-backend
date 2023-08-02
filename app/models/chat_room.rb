class ChatRoom < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'
  has_many :messages, dependent: :destroy
  
  validates :overall_sentiment_analysis_score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
end
