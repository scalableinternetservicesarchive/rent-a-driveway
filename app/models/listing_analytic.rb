class ListingAnalytic < ActiveRecord::Base
  belongs_to :listing, :class_name => 'Listing', :foreign_key => 'listing_id'

  validates :view_count, presence: true
end
