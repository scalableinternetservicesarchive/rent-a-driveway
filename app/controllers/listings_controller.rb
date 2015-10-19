class ListingsController < ApplicationController

  def index
    # @listing = current_user_listings(current_user)
    @listing = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
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

    def current_user_listings(user)
      Listing.where("listings.owner_id = ?", user.id).order('created_at asc')
    end
end
