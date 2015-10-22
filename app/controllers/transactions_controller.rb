class TransactionsController < ApplicationController
  def index
    @buyer_transactions = current_user.buyer_transactions
    @seller_transactions = current_user.seller_transactions
  end

  def new
    @transaction = Transaction.new
    @transaction.seller_id = params[:seller_id]
    @transaction.buyer_id = current_user.id
    @transaction.listing_id = params[:listing_id]

    #add paypal transaction here
    @listing = Listing.find(params[:listing_id])
    @listing.status = 1 # status: closed
    @listing.save
    if @transaction.save
      redirect_to '/'
    else
      #change to fail page
      redirect_to '/'
    end
  end
end
