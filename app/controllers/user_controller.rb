class UserController < ApplicationController
  def profile
    @listings = current_user_listings(current_user)
  end

  def transaction
	@seller = "Name"
	@address = "address"
	price = 100;
	@price = sprintf("%0.02f", price)
  end
  
  def pay
	#TODO: payment methods
	rec = "rent.a.driveway@gmail.com"
	venmo = "https://venmo.com/?txn=pay&audience=private&amount=#{params[:price]}&recipients=#{rec}"
	redirect_to(venmo)  
  end

  private
    def current_user_listings(user)
      Listing.where("listings.owner_id = ?", user.id).order('created_at asc')
    end
end
