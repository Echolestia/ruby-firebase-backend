class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_type
      t.string :profile
      t.string :first_name
      t.string :second_name
      t.integer :age
      t.string :occupation
      t.string :username
      t.string :phone_number
      t.string :gender
      t.boolean :pregnant
      t.string :marital_status
      t.integer :pregnancy_week
      t.boolean :is_anonymous_login
      t.string :survey_result
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
