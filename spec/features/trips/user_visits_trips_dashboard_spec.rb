# As a registered user,
# When I visit '/trips-dashboard',
# -[ ] I see the Station with the most rides as a starting place,
# -[ ] I see the Station with the most rides as an ending place,
# -[ ] I see Month by Month breakdown of number of rides with subtotals for each year,
# -[ ] I see the User subscription type breakout with both count and percentage,

require 'rails_helper'

describe 'as a registered user logging in and visiting /trips-dashboard' do
  xit 'sees a trips dashboard of relevent information' do
    Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
    Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")

    10.times do
      Trip.create!(duration: 60, start_date: Date.today.strftime("%m/%d/%Y"),
                   start_station_id: 1, end_date: Date.today.strftime("%m/%d/%Y"),
                   end_station_id: 2, bike_id: 563,
                   subscription_type: 'Subscriber', zip_code: 94127)
    end
    5.times do
      Trip.create!(duration: 20, start_date: Date.yesterday.strftime("%m/%d/%Y"),
                   start_station_id: 1, end_date: Date.yesterday.strftime("%m/%d/%Y"),
                   end_station_id: 2, bike_id: 120,
                   subscription_type: 'Customer', zip_code: 94127)
    end
    2.times do
      Trip.create!(duration: 15, start_date: Date.tomorrow.strftime("%m/%d/%Y"),
                   start_station_id: 1, end_date: Date.tomorrow.strftime("%m/%d/%Y"),
                   end_station_id: 2, bike_id: 111,
                   subscription_type: 'Subscriber', zip_code: 94127)
    end

    name1 = 'john316'
    password1 = 'secret'
    user = User.create!(username: name1, password: password1, role: 0)
    average_trip_duration             = Trip.average_trip_duration
    longest_duration                  = Trip.longest_duration
    shortest_duration                 = Trip.shortest_duration
    most_ridden_bike_id               = Trip.most_ridden_bike[0]
    most_ridden_bike_count            = Trip.most_ridden_bike[1]
    least_ridden_bike_id              = Trip.least_ridden_bike[0]
    least_ridden_bike_count           = Trip.least_ridden_bike[1]
    date_of_most_trips                = Trip.most_popular_date[0]
    date_of_most_trips_ride_count     = Trip.most_popular_date[1]
    date_of_least_trips               = Trip.least_popular_date[0]
    date_of_least_trips_ride_count    = Trip.least_popular_date[1]
    subscriber_subscription_breakdown = Trip.subscription_type_breakdown.last
    customer_subscription_breakdown   = Trip.subscription_type_breakdown.first

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit trips_dashboard_path

    expect(page).to have_content(average_trip_duration)
    expect(page).to have_content(longest_duration)
    expect(page).to have_content(shortest_duration)

    expect(page).to have_content(most_ridden_bike_id)
    expect(page).to have_content(most_ridden_bike_count)

    expect(page).to have_content(least_ridden_bike_id)
    expect(page).to have_content(least_ridden_bike_count)

    expect(page).to have_content(date_of_most_trips)
    expect(page).to have_content(date_of_most_trips_ride_count)

    expect(page).to have_content(date_of_least_trips)
    expect(page).to have_content(date_of_least_trips_ride_count)

    expect(page).to have_content(subscriber_subscription_breakdown[0])
    expect(page).to have_content(subscriber_subscription_breakdown[1][0])
    expect(page).to have_content(subscriber_subscription_breakdown[1][1])

    expect(page).to have_content(customer_subscription_breakdown[0])
    expect(page).to have_content(customer_subscription_breakdown[1][0])
    expect(page).to have_content(customer_subscription_breakdown[1][1])
  end
end
