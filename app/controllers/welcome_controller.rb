class WelcomeController < ApplicationController
    def index
        @cur_lat = Rails.env.production? ? request.location.latitude : 34.068921
        @cur_lng = Rails.env.production? ? request.location.longitude : -118.445181
        @nearby_listings = Listing.near([@cur_lat, @cur_lng], 2)
        @markers = Gmaps4rails.build_markers(@nearby_listings) do |listing, marker|
            marker.lat listing.latitude
            marker.lng listing.longitude
            marker.infowindow  "Address: #{listing.address}<br />Price: $#{listing.price}<br /><a href=#{listing_path(listing)}>Details</a>"
        end
    end
end
