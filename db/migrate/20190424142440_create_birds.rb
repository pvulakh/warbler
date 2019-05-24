class CreateBirds < ActiveRecord::Migration[5.2]
  def change
    create_table :birds do |t|
      t.string :username, null: false # t.string( :username, { :null => false })
      t.integer :location_id, null: false 
    end
  end
end

# any migration modifies our database
# don't need to worry about ids when generating tables; migrations take care of it for us