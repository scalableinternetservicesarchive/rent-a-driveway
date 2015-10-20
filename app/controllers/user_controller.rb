class UserController < ApplicationController
  def index
    @listings = current_user_listings(current_user)
  end
  
  private
    def current_user_listings(user)
      Listing.where("listings.owner_id = ?", user.id).order('created_at asc')
    end
end
