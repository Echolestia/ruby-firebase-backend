class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :type
      t.string :profile
      t.string :first_name
      t.string :second_name
      t.integer :age
      t.string :occupation
      t.string :username
      t.string :phone_number

      t.timestamps
    end
  end
end
