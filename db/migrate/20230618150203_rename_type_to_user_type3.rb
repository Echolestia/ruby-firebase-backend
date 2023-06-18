class RenameTypeToUserType3 < ActiveRecord::Migration[6.0]
  def change
    rename_column :messages, :type, :message_type
  end
end
