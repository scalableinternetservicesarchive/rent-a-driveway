class TransactionsController < ApplicationController
  def index
    @buyer_transactions = transaction_buyer_info(current_user)
    @seller_transactions = transaction_seller_info(current_user)
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

  private
    def transaction_buyer_info(user)
      Transaction.joins(:listing).joins(:seller).select("users.first_name, users.last_name, listings.address, listings.price").where("transactions.buyer_id = ?", user.id)
    end
    def transaction_seller_info(user)
      Transaction.joins(:listing).joins(:buyer).select("users.first_name, users.last_name, listings.address, listings.price").where("transactions.seller_id = ?", user.id)
    end
end
