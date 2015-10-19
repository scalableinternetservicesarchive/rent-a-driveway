class TransactionsController < ApplicationController
  def index
    #@transaction = current_user_transactions(current_user)
    @transaction = Transaction.all
  end

  def new
    @transaction = Transaction.new
    @transaction.seller_id = params[:seller_id]
    @transaction.buyer_id = current_user.id
    @transaction.listing_id = params[:listing_id]

    #add paypal transaction here

    if @transaction.save
      redirect_to '/'
    else
      #change to fail page
      redirect_to '/'
    end
  end

end
