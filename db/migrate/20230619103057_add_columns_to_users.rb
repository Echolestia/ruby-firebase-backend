class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :pregnant, :boolean
    add_column :users, :marital_status, :string
    add_column :users, :pregnancy_week, :integer
    add_column :users, :is_anonymous_login, :boolean
    add_column :users, :survey_result, :string
  end
end
