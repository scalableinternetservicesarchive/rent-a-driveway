class UserController < ApplicationController
  def index
    @users = User.all
    @users.each do |user|
      user.type = get_type(user)
    end
  end

  def show
    @user = User.find(params[:id])
    @listings = @user.listings
    @type = get_type(@user)
  end

  private

    def get_type(user)
      @type_array = Array.new
      @type_array.push("Admin") if user.is_admin
      @type_array.push("Buyer") if user.is_buyer
      @type_array.push("Seller") if user.is_seller
      return @type_array.join(",")
    end
end