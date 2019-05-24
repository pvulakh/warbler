class RenameUsernameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :birds, :username, :name
  end
end
