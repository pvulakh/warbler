class CreateWarbles < ActiveRecord::Migration[5.2]
  def change
    create_table :warbles do |t|
      t.string :body, null: false 
      t.integer :bird_id, null: false
      t.timestamps
    end
  end
end
