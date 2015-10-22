class ListingsController < ApplicationController

  def index
    # @listing = current_user_listings(current_user)
    @listing = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
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
    @hash = Gmaps4rails.build_markers(@listing) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
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

  private

    def listing_params
      params.require(:listing).permit(:address, :start_time, :end_time, :price)
    end
end
