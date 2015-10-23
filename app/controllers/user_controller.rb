class UserController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @listings = @user.listings
	@type = ""
	if @user.is_admin
		@type += "Admin"
	end
	if @user.is_buyer
		if not @type.empty?
			@type += ", "
		end
		@type += "Buyer"
	end
	if @user.is_seller
		if not @type.empty?
			@type += ", "
		end
		@type += "Seller"
	end
  end
end
