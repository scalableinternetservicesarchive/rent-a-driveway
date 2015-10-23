
def get_address()
  lat = 34.0722
  lng = -118.4451

  lat += rand(-0.0075...0.0075)
  lng += rand(-0.0075...0.0075)

  while true do
    query = "#{lat},#{lng}"
    result = Geocoder.search(query).first
    if result.present?
      break
    else
      lat += rand(-0.0005...0.0005)
      lng += rand(-0.0005...0.0005)
    end
  end

  return result.address
end

Fabricator(:listing) do
  owner { Fabricate(:user, is_seller: true) }
  address { get_address() }
  start_time { Faker::Date.between(Date.today, 20.days.from_now)}
  end_time { Faker::Date.between(21.days.from_now, 40.days.from_now)}
  price { Faker::Number.decimal(3, 2) }
end