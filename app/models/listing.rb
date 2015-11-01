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
  has_attached_file :listing_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "listing_images/default.png"
  validates_attachment_content_type :listing_image, :content_type => %w(image/jpeg image/jpg image/png)
  
  def distance
    @distance
  end

  def minimum_price
    @minumum_price
  end

  def maximum_price
    @maximum_price
  end

  def listings
    @listings = Listing.all
  end
end
