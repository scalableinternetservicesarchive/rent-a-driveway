# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.where(email: "admin@rad.com").blank?
    1.times { Fabricate(:user, is_admin: true, email: "admin@rad.com") }
    print "seeding database"
    500.times { Fabricate(:listing) }
    50.times { Fabricate(:user, is_buyer: true) }
end
