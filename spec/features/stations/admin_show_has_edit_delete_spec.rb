require 'rails_helper'

describe 'visitor' do
  context 'admin stations index page' do
    it 'should see a list of stations with all attributes' do
      admin = User.create(username: "penelope", password: "boom", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)


      visit "/station/#{station.name}"

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end

    it 'should see an edit button next to each station' do
      admin = User.create(username: "penelope", password: "boom", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      click_link('Edit')

      expect(current_path).to eq(edit_admin_station_path(station))
    end

    it 'should see an delete button next to each station' do
      admin = User.create(username: "penelope", password: "boom", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      click_link('Delete')

      expect(current_path).to eq(stations_path)
    end
  end
end
