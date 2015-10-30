class AddAttachmentListingImageToListings < ActiveRecord::Migration
  def self.up
    change_table :listings do |t|
      t.attachment :listing_image
    end
  end

  def self.down
    remove_attachment :listings, :listing_image
  end
end
