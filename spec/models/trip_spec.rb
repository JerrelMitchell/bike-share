require 'rails_helper'

RSpec.describe Trip, type: :model do
  before(:each) do
    Station.create(name: 'Denver', dock_count: 5, city: 'Fort Collins')
    Station.create(name: 'Dallas', dock_count: 5, city: 'Fort Collins')
    10.times do
      Station.create(name: 'Santa Fe', dock_count: 5, city: 'Fort Collins')
      Station.create(name: 'Park', dock_count: 5, city: 'Fort Collins')
      Trip.create!(duration: 60, start_date: Time.now,
                   start_station_id: 1, end_date: Time.now,
                   end_station_id: 2, bike_id: 520,
                   subscription_type: 'Subscriber', zip_code: 94127)
    end
    5.times do
      Trip.create!(duration: 20, start_date: Time.now,
                   start_station_id: 1, end_date: Time.now,
                   end_station_id: 2, bike_id: 55,
                   subscription_type: 'Customer', zip_code: 93123)
    end
  end

  context 'validations' do
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:start_station) }
    it { should validate_presence_of(:end_station) }
    it { should validate_presence_of(:bike_id) }
    it { should validate_presence_of(:subscription_type) }
  end

  context 'has model level dashboard methods' do

    it 'Trip#average_trip_duration' do
      expect(Trip.average_trip_duration).to eq(46)
    end

    it 'Trip#longest_duration' do
      expect(Trip.longest_duration).to eq(60)
    end

    it 'Trip#shortest_duration' do
      expect(Trip.shortest_duration).to eq(20)
    end

    it 'Trip#most_popular_start_station' do
      expect(Trip.most_popular_start_station).to eq('Denver')
    end

    it 'Trip#most_popular_end_station' do
      expect(Trip.most_popular_end_station).to eq('Dallas')
    end

    it 'Trip#most_ridden_bike' do
      expect(Trip.most_ridden_bike).to eq([520, 10])
    end

    it 'Trip#least_ridden_bike' do
      expect(Trip.least_ridden_bike).to eq([55, 5])
    end

    it 'Trip#most_popular_date' do
      expect(Trip.most_popular_date).to eq([Date.today, 15])
    end

    it 'Trip#least_popular_date' do
      expect(Trip.least_popular_date).to eq([Date.today, 15])
    end

    it 'Trip#subscription_type_percents' do
      expect(Trip.subscription_type_percents).to eq([['Customer', 33.33], ['Subscriber', 66.67]])
    end

    it 'Trip#subscription_type_counts' do
      expect(Trip.subscription_type_counts).to eq('Subscriber' => 10, 'Customer' => 5)
    end

    it 'Trip#subscription_type_breakdown' do
      expect(Trip.subscription_type_breakdown).to eq([[5, ['Customer', 33.33]], [10, ['Subscriber', 66.67]]])
    end

    it 'Trip#start_station_names' do
      expect(Trip.start_station_names).to eq(['Denver'])
    end

    it 'Trip#end_station_names' do
      expect(Trip.end_station_names).to eq(['Dallas'])
    end

    it 'Trip#subscription_types' do
      expect(Trip.subscription_types).to eq(['Subscriber', 'Customer'])
    end
  end
end
