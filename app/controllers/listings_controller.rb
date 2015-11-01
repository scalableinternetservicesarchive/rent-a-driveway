class ListingsController < ApplicationController
  include ListingsHelper
  helper_method :sort_column, :sort_direction

  def index
    @listing_params = session[:listing_search_params]
    if (@listing_params)
      @clauses = search_conditions(@listing_params)
      @listing = Listing.near(@listing_params['address'].to_s(), 2).where(@clauses.to_s()).order(sort_column + " " + sort_direction)
      session[:query_start_time] = @query_start_time
      session[:query_end_time] = @query_end_time
    else
      @listing = Listing.all.order(sort_column + " " + sort_direction)
      session[:query_start_time] = nil
      session[:query_end_time] = nil
    end 
    session[:listing_search_params] = nil
  end

  def show
    @listing = Listing.find(params[:id])

    if (!session[:query_start_time].blank? && !session[:query_end_time].blank? )
      @query_start_time = DateTime.parse(session[:query_start_time])
      @query_end_time = DateTime.parse(session[:query_end_time])
    else
      @query_start_time = @listing.start_time
      @query_end_time = @listing.end_time
    end

    @listing_analytics = @listing.listing_analytics
    @nearby_listings = @listing.nearbys(2)
    @listing_analytics_locations = @listing_analytics.listing_analytics_locations
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
    session[:listing_search_params] = listing_params
    redirect_to listings_path
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

    def sort_column
      Listing.column_names.include?(params[:sort]) ? params[:sort] : "price"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
