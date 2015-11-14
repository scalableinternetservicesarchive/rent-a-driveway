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

  def search_conditions(listing_params)
    conditions = Array.new
    preprocess_listing_params(listing_params)
    param_names = get_param_names
    param_names.each do |param_name|
      conditions.push(send(param_name.to_s() + "_condition", listing_params[param_name.to_s()])) unless listing_params[param_name.to_s()].blank?
    end
    conditions.join(' AND ')
  end
private
  def get_param_names
    param_names = ["start_date_time", "end_date_time", "minimum_price", "maximum_price"]
  end

  def preprocess_listing_params(listing_params)
    if !listing_params['start_date'].blank? && !listing_params['start_time'].blank?
      @query_start_date_time = DateTime.strptime("#{listing_params['start_date']} #{listing_params['start_time']}", '%Y-%m-%d %H:%M')
      listing_params.delete('start_time')
      listing_params.delete('start_date')
      @query_start_date_time = @query_start_date_time.to_s(:db)
      listing_params['start_date_time'] = @query_start_date_time
    elsif !listing_params['start_date'].blank?
      @query_start_date_time = DateTime.strptime("#{listing_params['start_date']}")
      listing_params.delete('start_date')
      @query_start_date_time = @query_start_date_time.to_s(:db)
      listing_params['start_date_time'] = @query_start_date_time
    end

    if !listing_params['end_date'].blank? && !listing_params['end_time'].blank?
      @end_date_time = DateTime.strptime("#{listing_params['end_date']} #{listing_params['end_time']}", '%Y-%m-%d %H:%M')
      listing_params.delete('end_time')
      listing_params.delete('end_date')
      @end_date_time = @end_date_time.to_s(:db)
      listing_params['end_date_time'] = @end_date_time
    elsif !listing_params['end_date'].blank?
      @end_date_time = DateTime.strptime("#{listing_params['end_date']}")
      listing_params.delete('end_date')
      @end_date_time = @end_date_time.to_s(:db)
      listing_params['start_date_time'] = @end_date_time
    end
  end

  def minimum_price_condition(minimum_price)
    "listings.price >= #{minimum_price}"
  end

  def maximum_price_condition(maximum_price)
    "listings.price <= #{maximum_price}"
  end

  def start_date_time_condition(start_date_time)
    "listings.start_time <= '#{start_date_time}'"
  end

  def end_date_time_condition(end_date_time)
    "listings.end_time >= '#{end_date_time}'"
  end
end
