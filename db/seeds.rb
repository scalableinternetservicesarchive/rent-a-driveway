# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

50.times { Fabricate(:listing_analytic) }
50.times { Fabricate(:user, is_buyer: true) }
if not User.where(email: 'admin@rad.com')
    1.times { Fabricate(:user, is_admin: true, email: "admin@rad.com") }
end
