require 'rails_helper'

describe 'As an admin user' do
  describe 'I delete a trip from the index page' do
    it 'shows a success message and successfully deletes the trip' do
      station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Blake St', dock_count: 10, city: "Denver")
      Trip.create!(duration: 30,
                   start_date: '5/12/2011 14:13',
                   end_date: '5/12/2011 14:24',
                   start_station_id: station2.id,
                   end_station_id: station1.id,
                   bike_id: 10,
                   subscription_type: 'Customer',
                   zip_code: 11234)
      name1 = 'john316'
      password1 = 'secret'
      admin = User.create!(username: name1, password: password1, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_path

      expect(Trip.count).to eq(1)
      expect(page).to have_content('Customer')

      click_on 'Delete'

      expect(Trip.count).to eq(0)
      expect(page).to_not have_content('Customer')
    end
  end
  describe 'I delete a trip from the show page' do
    it 'shows a success message and successfully deletes the trip' do
      station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Blake St', dock_count: 10, city: "Denver")
      trip = Trip.create!(duration: 30,
                          start_date: '5/12/2011 14:13',
                          end_date: '5/12/2011 14:24',
                          start_station_id: station2.id,
                          end_station_id: station1.id,
                          bike_id: 10,
                          subscription_type: 'Customer',
                          zip_code: 11234)
      name1 = 'john316'
      password1 = 'secret'
      admin = User.create!(username: name1, password: password1, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trip_path(trip)

      expect(Trip.count).to eq(1)
      expect(page).to have_content('Customer')

      click_on 'Delete'

      expect(Trip.count).to eq(0)
      expect(page).to_not have_content('Customer')
    end
  end
end
