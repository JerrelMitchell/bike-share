require 'rails_helper'

describe 'opens trips index page' do
  context 'as visitor' do
    it 'allows me to see up to 30 trips per page' do
      35.times do
        Trip.create!(duration: 63, start_date: '8/29/2013 14:13',
                     start_station: 10, end_date: '8/30/2013 11:14',
                     end_station: 66, bike_id: 520,
                     subscription_type: 'Subscriber', zip_code: 94127)
      end
      trip = Trip.first

      visit trips_path

      expect(page).to have_content('Trips')
      expect(page).to have_content(trip.duration, count: 30)
      expect(page).to have_content(trip.start_date, count: 30)
      expect(page).to have_content(trip.start_station, count: 30)
      expect(page).to have_content(trip.end_date, count: 30)
      expect(page).to have_content(trip.end_station, count: 30)
      expect(page).to have_content(trip.bike_id, count: 30)
      expect(page).to have_content(trip.subscription_type, count: 30)
      expect(page).to have_content(trip.zip_code, count: 30)

      click_on 'Next →'

      expect(page).to have_content(trip.duration, count: 5)
      expect(page).to have_link('← Previous')
    end
  end
end
