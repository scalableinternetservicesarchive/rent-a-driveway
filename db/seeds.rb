# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

buyer = User.create!(first_name: 'Foo', last_name: 'Bar',
                    is_buyer: true, email: 'buyer@gmail.com', 
                    password: 'password', password_confirmation: 'password')

seller = User.create!(first_name: 'Foo', last_name: 'Bar',
                     is_seller: true, email: 'seller@gmail.com', 
                     password: 'password', password_confirmation: 'password')

listing = Listing.create( owner_id: seller.id,
                          address: '90024', 
                          start_time: DateTime.strptime("01/01/2015 17:00", "%m/%d/%Y %H:%M"),
                          end_time: DateTime.strptime("01/02/2015 17:00", "%m/%d/%Y %H:%M"),
                          price: 200)