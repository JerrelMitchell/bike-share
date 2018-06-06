describe 'As an admin user' do
  describe 'I can edit a trip from the trip show or index pages' do
    xit 'shows a success message and successfully updates the trip' do
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
      new_duration = "40"
      new_start_date = '3/11/2012 13:13'
      new_end_date = '3/11/2012 14:13'
      new_start_station = station1.id
      new_end_station = station2.id
      new_bike_id = "12"
      new_subscription_type = 'Subscriber'
      new_zip_code = "123456"
      error = "Fill in all fields before submitting, or ensure Station ID is valid!"

      visit trips_path

      click_on 'Edit'

      expect(current_path).to eq(edit_admin_trip_path(trip))

      visit trip_path(trip)
      expect(page).to have_content("Trip to #{trip.end_station.name} from #{trip.start_station.name}")

      click_on 'Edit'
      fill_in 'trip[duration]', with: ''
      click_on 'Update Trip'
      expect(page).to have_content(error)

      fill_in 'trip[duration]', with: new_duration
      fill_in 'trip[start_date]', with: new_start_date
      fill_in 'trip[end_date]', with: new_end_date
      fill_in 'trip[start_station_id]', with: new_start_station
      fill_in 'trip[end_station_id]', with: new_end_station
      fill_in 'trip[bike_id]', with: new_bike_id
      fill_in 'trip[subscription_type]', with: new_subscription_type
      fill_in 'trip[zip_code]', with: new_zip_code

      click_on 'Update Trip'

      expect(page).to_not have_content(trip.duration)
      expect(page).to_not have_content(trip.start_date)
      expect(page).to_not have_content(trip.end_date)
      expect(page).to_not have_content(trip.bike_id)
      expect(page).to_not have_content(trip.subscription_type)
      expect(page).to_not have_content(trip.zip_code)
    end
  end
end
