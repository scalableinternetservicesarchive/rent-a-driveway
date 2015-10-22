class Listing < ActiveRecord::Base
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :price, presence: true
  validates :address, presence: true

  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  has_one :listing_analytics, :class_name => 'ListingAnalytic', :foreign_key => 'listing_id'
  has_many :transactions, :class_name => 'Transaction', :foreign_key => 'listing_id'

  geocoded_by :address
  after_validation :geocode
  enum status: [:OPEN, :CLOSED]
end
