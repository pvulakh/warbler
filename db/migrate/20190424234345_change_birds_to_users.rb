class ChangeBirdsToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :birds, :users
  end
end
