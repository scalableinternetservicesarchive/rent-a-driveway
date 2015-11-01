class TransactionsController < ApplicationController
  def index
    @buyer_transactions = current_user.buyer_transactions
    @seller_transactions = current_user.seller_transactions
  end

  def new
  	@listing = Listing.find(flash[:listing_id])
  	#pass these values to the create action
    flash[:listing_id] = params[:listing_id]
    flash[:seller_id] = params[:seller_id]

    #used for payment
    @client_token = Braintree::ClientToken.generate
  end

  def create
  	@listing = Listing.find(flash[:listing_id])

  	#send payment info to Braintree
    nonce = params[:payment_method_nonce]
	render action: :new and return unless nonce
	result = Braintree::Transaction.sale(
	  amount: @listing.price,
	  payment_method_nonce: nonce
	)
	if result.success?
		flash[:notice] =  "Payment accepted!"

		@listing.status = 1 # status: closed
    	@listing.save

    	Transaction.create(
    		seller_id: flash[:seller_id],
    		buyer_id: current_user.id,
    		listing_id: flash[:listing_id])

    	render :create
    else
		flash[:notice] = "Something went wrong." 
		render :create
	end
  end
  
end
