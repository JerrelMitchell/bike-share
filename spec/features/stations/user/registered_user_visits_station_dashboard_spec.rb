require 'rails_helper'
require 'date'

describe 'registered user' do
  context 'visits stations dashboard page /stations-dashboard' do
    it 'should show the total station count' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/stations-dashboard"
      expect(current_path).to eq("/stations-dashboard")

      expect(page).to have_content(Station.total_count)
    end

    it 'should show the average bikes available per station (based on docks)' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 12, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station3 = Station.create(name: 'Fort', dock_count: 9, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 220, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/stations-dashboard"
      expect(current_path).to eq("/stations-dashboard")

      expect(page).to have_content(Station.average_bikes)
    end

    it 'should show the most bikes available at a station (based on docks)' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 12, city: "Fort Collins")
      station2 = Station.create(name: 'test', dock_count: 5, city: "Fort Collins")
      station3 = Station.create(name: 'test', dock_count: 9, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 220, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/stations-dashboard"
      expect(current_path).to eq("/stations-dashboard")
      expect(page).to have_content(Station.most_bikes.name)
    end

    it 'should show the Station(s) where the most bikes are available (based on docks)' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station1 = Station.create(name: 'Sab', dock_count: 12, city: "Fort Collins")
      station2 = Station.create(name: 'Jerr', dock_count: 10, city: "Fort Collins")
      station3 = Station.create(name: 'Bruhhhh', dock_count: 9, city: "Fort Collins")
      station4 = Station.create(name: 'Jimbo Slice', dock_count: 7, city: "Fort Collins")
      station5 = Station.create(name: 'LalaLand', dock_count: 5, city: "Fort Collins")
      station6 = Station.create(name: 'Als', dock_count: 4, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station1.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station1.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 220, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/stations-dashboard"

      expect(current_path).to eq("/stations-dashboard")
      expect(page).to have_content(station1.name)
      expect(page).to have_content(station2.name)
      expect(page).to have_content(station3.name)
      # expect(page).to_not have_content(station4.name)
    end

    it 'should show the Station(s) where the least bikes are available (based on docks)' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station1 = Station.create(name: 'station1', dock_count: 12, city: "Fort Collins")
      station2 = Station.create(name: 'station2', dock_count: 10, city: "Fort Collins")
      station3 = Station.create(name: 'station3', dock_count: 9, city: "Fort Collins")
      station4 = Station.create(name: 'station4', dock_count: 7, city: "Fort Collins")
      station5 = Station.create(name: 'station5', dock_count: 5, city: "Fort Collins")
      station6 = Station.create(name: 'station6', dock_count: 4, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station1.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station1.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 220, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/stations-dashboard"

      expect(current_path).to eq("/stations-dashboard")
      expect(page).to have_content(station6.name)
      expect(page).to have_content(station5.name)
      expect(page).to have_content(station4.name)
      # expect(page).to_not have_content(station1.name)
    end

    it 'should show the Most recently installed station' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      date1 = Date.strptime("6/15/2012", '%m/%d/%Y')
      date2 = Date.strptime("7/15/2010", '%m/%d/%Y')
      date3 = Date.strptime("12/20/2009", '%m/%d/%Y')
      station1 = Station.create(name: 'Sab', dock_count: 12, city: "Fort Collins", installation_date: date1)
      station2 = Station.create(name: 'Jerr', dock_count: 10, city: "Fort Collins", installation_date: date2)
      station3 = Station.create(name: 'Bruhhhh', dock_count: 9, city: "Fort Collins", installation_date: date3)

      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station1.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station1.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 220, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/stations-dashboard"

      expect(current_path).to eq("/stations-dashboard")
      expect(page).to have_content(Station.newest_station)
    end

    it 'should show the oldest station' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      date1 = Date.strptime("6/15/2012", '%m/%d/%Y')
      date2 = Date.strptime("7/15/2010", '%m/%d/%Y')
      date3 = Date.strptime("12/20/2009", '%m/%d/%Y')
      station1 = Station.create(name: 'Sab', dock_count: 12, city: "Fort Collins", installation_date: date1)
      station2 = Station.create(name: 'Jerr', dock_count: 10, city: "Fort Collins", installation_date: date2)
      station3 = Station.create(name: 'Bruhhhh', dock_count: 9, city: "Fort Collins", installation_date: date3)

      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station1.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station1.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 220, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/stations-dashboard"

      expect(current_path).to eq("/stations-dashboard")
      expect(page).to have_content(Station.oldest_station)
    end
  end
end