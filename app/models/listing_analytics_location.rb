class ListingAnalyticsLocation < ActiveRecord::Base
  belongs_to :listing_analytics, :class_name => 'ListingAnalytic', :foreign_key => 'listing_analytics_id'
  geocoded_by :ip
  after_validation :geocode
end
