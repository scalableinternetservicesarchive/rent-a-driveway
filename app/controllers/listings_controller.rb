class ListingsController < ApplicationController
  def index
    @listing = Listing.all
  end

  def show
  	@listing = Listing.find(params[:id])
  end

  def new
  end

  def create
 	@listing = Listing.new(listing_params)
 	@listing.save
 	redirect_to @listing
  end

  private

    def listing_params
      params.require(:listing).permit(:start_time, :end_time, :price)
    end

end
