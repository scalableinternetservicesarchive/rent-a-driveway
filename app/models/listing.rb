class Listing < ActiveRecord::Base
	validates :start_time, presence: true
  validates :end_time, presence: true
	validates :price, presence: true
  validates :address, presence: true
	belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  geocoded_by :address
  after_validation :geocode
  enum status: [:OPEN, :CLOSED]
end
