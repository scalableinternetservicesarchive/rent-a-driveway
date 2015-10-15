class Listing < ActiveRecord::Base
	validates :start_time, presence: true
	validates :price, presence: true
end
