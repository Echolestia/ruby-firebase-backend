# db/migrate/xxxxxxxxxx_change_type_name_in_users.rb

class ChangeTypeNameInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :type, :userType
  end
end
