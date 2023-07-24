class Article < ApplicationRecord
    serialize :user_group, Array
    validates :title, presence: true
  end
  