class TransactionsController < ApplicationController
  def index
    @buyer_transactions = current_user.buyer_transactions
    @seller_transactions = current_user.seller_transactions
  end

  def new
  	@listing = Listing.find(params[:listing_id])
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

    @old_start_time = @listing.start_time
    @old_end_time = @listing.end_time

    @listing.start_time = session[:query_start_time]
    @listing.end_time = session[:query_end_time]
		@listing.status = 2 # status: end
    if @listing.save
      @start_time_diff = (DateTime.parse(session[:query_start_time].to_s()) - DateTime.parse(@old_start_time.to_s())).to_i * 24 * 60
      @end_time_diff = (DateTime.parse(@old_end_time.to_s()) - DateTime.parse(session[:query_end_time].to_s())).to_i * 24 * 60
      
      if @start_time_diff >= 30
        puts "Creating Left"
        @left_child_listing = Listing.new
        @left_child_listing.owner_id = @listing.owner_id
        @left_child_listing.address = @listing.address
        @left_child_listing.start_time = @old_start_time
        @left_child_listing.end_time = session[:query_start_time]
        @left_child_listing.price = @listing.price
        @left_child_listing.listing_image = @listing.listing_image
        @left_child_listing.save
      end
      
      if @end_time_diff >= 30
        puts "Creating Right"
        @right_child_listing = Listing.new
        @right_child_listing.owner_id = @listing.owner_id
        @right_child_listing.address = @listing.address
        @right_child_listing.start_time = session[:query_end_time]
        @right_child_listing.end_time = @old_end_time
        @right_child_listing.price = @listing.price
        @right_child_listing.listing_image = @listing.listing_image
        @right_child_listing.save
      end

    end
    Transaction.create(
    	seller_id: flash[:seller_id],
    	buyer_id: current_user.id,
    	listing_id: flash[:listing_id]
    )

    render :create
  else
		flash[:notice] = "Something went wrong." 
		render :create
	end
  end
  
end
