class RenameTypeToUserType2 < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :userType, :user_type
  end
end
