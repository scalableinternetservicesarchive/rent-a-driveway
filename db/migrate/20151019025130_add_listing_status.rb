class AddListingStatus < ActiveRecord::Migration
  def change
    add_column :listings, :status, :integer, :default => 0
  end
end
