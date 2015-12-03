class ListingsController < ApplicationController
  include ListingsHelper
  include ApplicationHelper

  respond_to :html, :js

  def index
	redirect_to('/')
  end

  def show
    @listing = Listing.find(params[:id])

    if (!session[:query_start_date_time].blank? && !session[:query_end_date_time].blank? )
      @query_start_date_time = DateTime.parse(session[:query_start_date_time])
      @query_end_date_time = DateTime.parse(session[:query_end_date_time])
    else
      @query_start_date_time = @listing.start_time
      @query_end_date_time = @listing.end_time
    end

    @listing_analytics = @listing.listing_analytics
    @nearby_listings = @listing.nearbys(2)
    if (!@listing_analytics.blank?)
      @listing_analytics_locations = @listing_analytics.listing_analytics_locations
    end
    @hash = Gmaps4rails.build_markers(@listing) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
    end
    @nearby_listings.each do |nearby_listing|
      nearby_listing.distance = @listing.distance_from(nearby_listing)
    end
  end

  def new
    @listing = Listing.new
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def create
 	  @listing = Listing.new(listing_params)
    @listing.owner_id = current_user.id

    Geocoder.coordinates(params[:address])

    if @listing.save
      @listing_analytics = ListingAnalytic.new
      @listing_analytics.listing_id = @listing.id
      @listing_analytics.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end
  
  def update
    @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render 'edit'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
   
    redirect_to listings_path
  end

  def search
    @listing_params = params.slice(:address, :start_date, :start_time, :end_date, :end_time, :minimum_price, :maximum_price)
    if (@listing_params)
      @clauses = search_conditions(@listing_params)
      puts @listing_params[:address]
      @listings = Listing.near(@listing_params['address'].to_s(), 2).where(@clauses.to_s()).reorder(sort_column + " " + sort_direction)
      session[:query_start_date_time] = @query_start_date_time
      session[:query_end_date_time] = @query_end_date_time
      chld = 0
      @markers = Gmaps4rails.build_markers(@listings) do |listing, marker|
        chld += 1
        marker.lat listing.latitude
        marker.lng listing.longitude
        marker.picture({ :url => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=#{chld}|EE1111|FFFFFF",
                         :width => 21,
                         :height => 34 })
        marker.infowindow  "Address: #{listing.address}<br />Price: $#{listing.price}<br /><a href=#{listing_path(listing)}>Details</a>"
        listing.address = chld
      end
    end
  end

  def log
    @listing = Listing.find(params[:listing_id])
    @listing_analytics = @listing.listing_analytics
    if current_user.try(:is_buyer)
      @listing_analytics.increment!(:view_count)
      @listing_analytics_location = ListingAnalyticsLocation.new
      if Rails.env.development?
        @listing_analytics_location.ip = Array.new(4){rand(256)}.join('.')
      else
        @listing_analytics_location.ip = request.remote_ip
      end
      @listing_analytics_location.listing_analytic_id = @listing_analytics.id
      @listing_analytics_location.save
    end
    @listing_analytics_locations = @listing_analytics.listing_analytics_locations
  end

  private
    def listing_params
      params.require(:listing).permit(:address, :start_time, :end_time, :price, :minimum_price, :maximum_price, :listing_image)
    end
end
