class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :owner
      t.string :address
      t.datetime :start_time
      t.datetime :end_time
      t.float :longitude
      t.float :latitude
      t.float :price

      t.timestamps null: false
    end
  end
end
