class ListingAnalytic < ActiveRecord::Base
  belongs_to :listing, :class_name => 'Listing', :foreign_key => 'listing_id'
  has_many :listing_analytics_locations, :class_name => 'ListingAnalyticsLocation', :foreign_key => 'listing_analytic_id'

  validates :view_count, presence: true
end
