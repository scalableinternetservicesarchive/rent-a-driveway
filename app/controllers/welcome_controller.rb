require 'geokit'

class WelcomeController < ApplicationController
    def index
        if params.has_key?(:location) and params.has_key?(:latitude) then
            a=Geokit::Geocoders::GoogleGeocoder.geocode params[:location]
            @cur_lat = a.lat
            @cur_lng = a.lng
            @got_startdatetime = true
            @start_datetime = "#{params[:start_date]} #{params[:start_time]}"
            @end_datetime = "#{params[:end_date]} #{params[:end_time]}"
        elsif Rails.env.production? then
            @cur_lat = request.location.latitude
            @cur_lng = request.location.longitude
            @got_startdatetime = false 
        else
            @cur_lat = 34.068921
            @cur_lng = -118.445181
            @got_startdatetime = false 
        end
        
        if @got_startdatetime then
            @nearby_listings = Listing.near([@cur_lat, @cur_lng], 2).where("start_time <= :start_time AND end_time >= :end_time", {start_time: @start_datetime,end_time: @end_datetime})
        else
            @nearby_listings = Listing.near([@cur_lat, @cur_lng], 2)
        end
        @markers = Gmaps4rails.build_markers(@nearby_listings) do |listing, marker|
            marker.lat listing.latitude
            marker.lng listing.longitude
            marker.infowindow  "Address: #{listing.address}<br />Price: $#{listing.price}<br /><a href=#{listing_path(listing)}>Details</a>"
        end
    end
end
