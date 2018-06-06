require 'rails_helper'

describe 'opens a trip show page' do
  context 'as visitor' do
    it 'allows me to see all details about the trip' do
      station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Blake St', dock_count: 10, city: "Denver")
      trip = Trip.create!(duration: 63,
                          start_date: Date.today,
                          end_date: Date.tomorrow,
                          start_station_id: station1.id,
                          end_station_id: station2.id,
                          bike_id: 520,
                          subscription_type: 'Subscriber',
                          zip_code: 94127)

      visit trip_path(trip)

      expect(page).to have_content(trip.duration)
      expect(page).to have_content(trip.start_date)
      expect(page).to have_content(trip.end_date)
      expect(page).to have_content(trip.start_station.name)
      expect(page).to have_content(trip.end_station.name)
      expect(page).to have_content(trip.bike_id)
      expect(page).to have_content(trip.subscription_type)
      expect(page).to have_content(trip.zip_code)
    end
  end
end
