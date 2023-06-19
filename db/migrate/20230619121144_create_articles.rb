class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.datetime :published_date
      t.datetime :created_date
      t.string :title
      t.string :author
      t.string :img_url
      t.string :url
      t.text :user_group
      t.timestamps
    end
  end
end
