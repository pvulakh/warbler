class ChangeBirdForeignKey < ActiveRecord::Migration[5.2]
  def change
    rename_column :warbles, :bird_id, :author_id
  end
end
