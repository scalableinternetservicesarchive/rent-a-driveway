module ListingsHelper
  def is_seller(user)
    user.try(:is_seller)
  end

  def is_buyer(user)
    user.try(:is_buyer)
  end

  def is_admin(user)
    user.try(:is_admin)
  end

  def owns_listing(user, listing)
    is_seller(user) && listing.owner_id == user.id
  end

  def user_can_buy(user, listing)
    is_buyer(user) && listing.status == "OPEN"
  end

  def user_can_view(user, listing)
    user_can_buy(user, listing) ||
    owns_listing(user, listing) || is_admin(user)
  end
end
