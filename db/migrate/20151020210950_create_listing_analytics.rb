class CreateListingAnalytics < ActiveRecord::Migration
  def change
    create_table :listing_analytics do |t|
      t.belongs_to :listing
      t.integer :view_count, default: 0
      t.timestamps null: false
    end
  end
end
