# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name: 'Buyer', last_name: '1',
            is_buyer: true, email: 'buyer_1@gmail.com', 
            password: 'password', password_confirmation: 'password')

User.create(first_name: 'Buyer', last_name: '2',
            is_buyer: true, email: 'buyer_2@gmail.com', 
            password: 'password', password_confirmation: 'password')

seller_1 = User.create(first_name: 'Seller', last_name: '1',
                     is_seller: true, email: 'seller_1@gmail.com', 
                     password: 'password', password_confirmation: 'password')

seller_2 = User.create(first_name: 'Seller', last_name: '2',
                     is_seller: true, email: 'seller_2@gmail.com',
                     password: 'password', password_confirmation: 'password')

Listing.create( owner_id: seller_1.id,
                address: '90024', 
                start_time: DateTime.strptime("01/01/2015 17:00", "%m/%d/%Y %H:%M"),
                end_time: DateTime.strptime("01/02/2015 17:00", "%m/%d/%Y %H:%M"),
                price: 200)

Listing.create( owner_id: seller_1.id,
                address: '90025',
                start_time: DateTime.strptime("01/03/2015 17:00", "%m/%d/%Y %H:%M"),
                end_time: DateTime.strptime("01/04/2015 17:00", "%m/%d/%Y %H:%M"),
                price: 200)

Listing.create( owner_id: seller_2.id,
                address: '90024', 
                start_time: DateTime.strptime("01/01/2015 17:00", "%m/%d/%Y %H:%M"),
                end_time: DateTime.strptime("01/02/2015 17:00", "%m/%d/%Y %H:%M"),
                price: 200)

Listing.create( owner_id: seller_2.id,
                address: '90025', 
                start_time: DateTime.strptime("01/03/2015 17:00", "%m/%d/%Y %H:%M"),
                end_time: DateTime.strptime("01/04/2015 17:00", "%m/%d/%Y %H:%M"),
                price: 200)