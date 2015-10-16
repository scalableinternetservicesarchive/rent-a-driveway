class UserController < ApplicationController
  def profile
	@name = "Name"
	@email = "email@email.com"
	@phone = "000-000-0000"
	@rating = 5.8     #0.0 to 10.0
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
end
