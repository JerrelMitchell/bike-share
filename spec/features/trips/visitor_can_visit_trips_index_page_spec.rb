require 'rails_helper'

describe 'opens trips index page' do
  context 'as visitor' do
    it 'allows me to see up to 30 trips per page' do
      Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Station.create(name: 'Blake', dock_count: 5, city: "Fort Collins")
      35.times do
        Trip.create!(duration: 63, start_date: Date.today.strftime("%m/%d/%Y"),
                     start_station_id: 1, end_date: Date.tomorrow.strftime("%m/%d/%Y"),
                     end_station_id: 2, bike_id: 520,
                     subscription_type: 'Subscriber', zip_code: 94127)
      end
      trip = Trip.first

      visit trips_path

      expect(page).to have_content('Trips')
      expect(page).to have_content(trip.duration, count: 30)
      expect(page).to have_content(trip.start_station.name, count: 30)
      expect(page).to have_content(trip.end_station.name, count: 30)
      expect(page).to have_content(trip.bike_id, count: 30)
      expect(page).to have_content(trip.subscription_type, count: 30)
      expect(page).to have_content(trip.zip_code, count: 30)

      click_on 'Next →'

      expect(page).to have_content(trip.duration, count: 5)
      expect(page).to have_link('← Previous')
    end
  end
end
