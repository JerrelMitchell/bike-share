require 'rails_helper'

describe 'As an admin user' do
  describe 'I create a trip from the index page' do
    it 'shows a success message and successfully creates the trip' do
      error = "Fill in all require fields, and make sure your Station ID is valid!"
      station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Blake St', dock_count: 10, city: "Denver")
      name1 = 'john316'
      password1 = 'secret'
      admin = User.create!(username: name1, password: password1, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      duration = 40
      start_date = '2013-03-11'
      end_date = '2013-03-11'
      start_station = station1.name
      end_station = station2.name
      bike_id = 12
      subscription_type = 'Subscriber'
      zip_code = 123456

      visit root_path
      click_on('Create Trip')

      expect(current_path).to eq(new_admin_trip_path)
      expect(page).to have_content('Create a new trip!')

      click_button 'Create Trip'
      expect(page).to have_content(error)

      fill_in 'trip[duration]', with: duration
      #start date
      select('2013', :from => 'trip[start_date(1i)]')
      select('March', :from => 'trip[start_date(2i)]')
      select('11', :from => 'trip[start_date(3i)]')
      #end date
      select('2013', :from => 'trip[end_date(1i)]')
      select('March', :from => 'trip[end_date(2i)]')
      select('11', :from => 'trip[end_date(3i)]')
      #start station
      select(start_station, :from => 'trip[start_station_id]')

      #end staion
      select(end_station, :from => 'trip[end_station_id]')
      #bike id
      fill_in 'trip[bike_id]', with: bike_id
      #subscription type
      select(subscription_type, :from => 'trip[subscription_type]')
      #zip code
      fill_in 'trip[zip_code]', with: zip_code

      within('[@id="new_trip"]') do
        click_on 'Create Trip'
      end

      expect(page).to have_content(duration)
      expect(page).to have_content(start_date)
      expect(page).to have_content(end_date)
      expect(page).to have_content(bike_id)
      expect(page).to have_content(subscription_type)
      expect(page).to have_content(zip_code)
    end
  end
end
