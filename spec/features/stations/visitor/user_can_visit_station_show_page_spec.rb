require 'rails_helper'
require 'date'

describe 'registered user' do
  context 'visits stations show page' do
    it 'should see current path as /:station-name' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      expect(current_path).to eq("/station/#{station.name}")
    end

    it 'should see a list of stations with all attributes' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      date = Date.strptime("6/15/2012", '%m/%d/%Y')
      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins", installation_date: date)
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end

    it 'should see the number of rides started at this station' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      expect(page).to have_content(station.started_at)
    end

    it 'should see the number of rides ended at this station' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      expect(page).to have_content(station.ended_at)
    end

    it 'should see the most frequent destination station (for rides beginning at this station)' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      expect(page).to have_content(station.popular_end_station)
    end

    it 'should see the most frequent origination station (for rides ending at this station)' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      expect(page).to have_content(station.popular_start_station)
    end

    it 'should see the date with the highest number of trips starting at this station' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")

      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/28/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      expect(page).to have_content(station.popular_date)
    end

    it 'should see the zip code with the highest number of trips starting at this station' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")

      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/28/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      expect(page).to have_content(station.popular_zip)
    end
    
    it 'should see the zip code with the highest number of trips starting at this station' do
      user = User.create(username: "penelope", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      station = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Fort', dock_count: 5, city: "Fort Collins")

      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 2, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      Trip.create(duration: 63, start_date: '8/28/2013 14:13', start_station_id: station.id, end_date: '8/29/2013 14:14', end_station_id: 1, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)

      visit "/station/#{station.name}"

      expect(page).to have_content(station.popular_bike)
    end
  end
end