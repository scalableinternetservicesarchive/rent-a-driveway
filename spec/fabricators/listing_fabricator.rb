Fabricator(:listing) do
  owner { Fabricate(:user, is_seller: true) }
  address { "dummy" }
  latitude { 34.0722 + rand(-0.250...0.250) }
  longitude { -118.4451 + rand(-0.250...0.250) }
  start_time { Faker::Date.between(Date.today, 20.days.from_now)}
  end_time { Faker::Date.between(21.days.from_now, 40.days.from_now)}
  price { Faker::Number.decimal(3, 2) }
end