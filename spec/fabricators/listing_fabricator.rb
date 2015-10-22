Fabricator(:listing) do
  owner { Fabricate(:user, is_seller: true) }
  address { Faker::Address.zip_code }
  start_time { Faker::Date.between(Date.today, 20.days.from_now)}
  end_time { Faker::Date.between(21.days.from_now, 40.days.from_now)}
  price { Faker::Number.decimal(3, 2) }
end
