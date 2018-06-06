# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
require 'date'
admin = User.create!(username: 'Pizza Cat', password: 'password', role: 1, full_name: "Pizza House Cat...Dog", address: "40W723 Willowbrook Drive, Saint Charles, IL, 60175")
user1 = User.create!(username: 'Jerrel', password: 'password', full_name: "John Dingleberry Livingston", address: "40W723 Willowbrook Drive, Saint Charles, IL, 60175")
user2 = User.create!(username: 'PettyPal', password: 'password', full_name: "John Dingleberry Livingston", address: "40W723 Willowbrook Drive, Saint Charles, IL, 60175")
date = Date.strptime("6/15/2012", '%m/%d/%Y')

date_from  = Date.parse('2010-10-14')
date_to    = Date.parse('2012-04-30')
date_range = date_from..date_to

date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
DATES = date_months.map {|d| d.strftime "%d/%m/%Y" }

STATION_NAMES = ["Blake", "Market", "City Park", "Lucinda", "Shields", "College", "Oak", "Old Town", "Mulberry", "Silver Glenn", "Corron"]
CITY = ["Fort Collins", "Denver", "Aurora", "Aspen", "Loveland", "Westminster", "Colorado Springs", "Golden", "Lakewood", "Arvada"]

STATUS = ["ordered", "completed", "paid", "cancelled"]

STATION_NAMES.map do |name|
  Station.create!(name: name, city: CITY.sample, dock_count: rand(0..12),
  installation_date: date)
end

SUB = ["Subscriber", "Customer"]
STARTDATE = ["2/24/2011 11:21", "2/30/2013 11:14", "3/12/2013 14:13"]
ENDDATE = ["8/29/2013 14:13", "8/30/2013 11:14",  "3/13/2013 11:14"]

200.times do
  Trip.create(duration: rand(1..100), start_date: DATES.sample, start_station_id: rand(1..11), end_date: DATES.sample, end_station_id: rand(1..11), bike_id: rand(1..100), subscription_type: SUB.sample, zip_code: rand(11111..99999))
end

ITEM = ["Cycling Computer", "Bike Computer", "Tail Light", "Saddle Bag",
  "Rear Bike Light", "Front Bike Light", "Water Bottle", "Water Bottle Holder",
  "Kickstand", "Helmet", "Gloves", "Bike Lock", "U Lock", "Bike Floor Pump",
  "Pedals", "Handle Bars", "Basket", "Bike Chain", "Multi-Tool", "Bean Rack"]

ITEM.map do |name|
  Accessory.create(title: name, description: 'Delicious!', thumbnail: 'bike_horse.jpg', price: 10 )
end

4.times do
  user1.orders.create!(status:rand(0..3))
  AccessoryOrder.create(accessory_id: rand(1..10), order_id:1)
  AccessoryOrder.create(accessory_id: rand(1..10), order_id:2)
  AccessoryOrder.create(accessory_id: rand(1..10), order_id:3)
  AccessoryOrder.create(accessory_id: rand(1..10), order_id:4)
end
