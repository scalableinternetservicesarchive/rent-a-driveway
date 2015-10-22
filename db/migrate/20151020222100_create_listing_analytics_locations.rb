class CreateListingAnalyticsLocations < ActiveRecord::Migration
  def change
    create_table :listing_analytics_locations do |t|
      t.belongs_to :listing_analytic
      t.string   :ip
      t.float :longitude
      t.float :latitude
      t.timestamps null: false
    end
  end
end
