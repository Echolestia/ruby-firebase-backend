class Article < ApplicationRecord
    serialize :user_group, Array
  end
  