class ListingsController < ApplicationController

  def index
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

    if @listing.save
 	    redirect_to @listing
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
      params.require(:listing).permit(:start_time, :end_time, :price)
    end

end
