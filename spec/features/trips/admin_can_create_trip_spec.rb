describe 'As an admin user' do
  describe 'I create a trip from the index page' do
    xit 'shows a success message and successfully creates the trip' do
      error = "Fill in all require fields, and make sure your Station ID is valid!"
      station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Blake St', dock_count: 10, city: "Denver")
      name1 = 'john316'
      password1 = 'secret'
      admin = User.create!(username: name1, password: password1, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      duration = 40
      start_date = '3/11/2012 13:13'
      end_date = '3/11/2012 14:13'
      start_station = station1.id
      end_station = station2.id
      bike_id = 12
      subscription_type = 'Subscriber'
      zip_code = 123456

      visit root_path
      click_on('Create New Trip')

      expect(current_path).to eq(new_admin_trip_path)
      expect(page).to have_content('Create a new trip!')

      click_on 'Create Trip'
      expect(page).to have_content(error)

      fill_in 'trip[duration]', with: duration
      fill_in 'trip[start_date]', with: start_date
      fill_in 'trip[end_date]', with: end_date
      fill_in 'trip[start_station_id]', with: start_station
      fill_in 'trip[end_station_id]', with: end_station
      fill_in 'trip[bike_id]', with: bike_id
      fill_in 'trip[subscription_type]', with: subscription_type
      fill_in 'trip[zip_code]', with: zip_code

      click_on 'Create Trip'

      expect(page).to have_content(duration)
      expect(page).to have_content(start_date)
      expect(page).to have_content(end_date)
      expect(page).to have_content(bike_id)
      expect(page).to have_content(subscription_type)
      expect(page).to have_content(zip_code)
    end
  end
end
