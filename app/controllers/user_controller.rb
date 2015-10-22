class UserController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @listings = current_user_listings(@user)
  end
  
  private
    def current_user_listings(user)
      Listing.where("listings.owner_id = ?", user.id).order('created_at asc')
    end
end
