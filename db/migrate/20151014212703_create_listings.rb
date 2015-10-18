class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.belongs_to :owner
      t.string :address
      t.datetime :start_time
      t.datetime :end_time
      t.float :longitude
      t.float :latitude
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps null: false
    end
  end
end
