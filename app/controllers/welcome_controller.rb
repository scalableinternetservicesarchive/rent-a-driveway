require 'geokit'

class WelcomeController < ApplicationController
  helper_method :sort_column, :sort_direction
    def index
        if Rails.env.production? then
            @cur_lat = request.location.latitude
            @cur_lng = request.location.longitude
        else
            @cur_lat = 34.068921
            @cur_lng = -118.445181
        end

      #TODO: search by price and make start time and end time optional
    end
  private
end
