class Article < ApplicationRecord
    serialize :user_group, Array
    validates :title, presence: true
    validates :title, :author, length: { maximum: 255 }
  end
  