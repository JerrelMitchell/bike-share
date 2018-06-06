require 'rails_helper'
require 'date'

describe Station, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:dock_count)}
  end

  describe 'instance methods' do
    before(:each) do
      @station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins")
      @station2 = Station.create(name: 'Blake St', dock_count: 10, city: "Denver")
      @trip1 = @station1.trips.create(duration: 63, start_date: Date.today, start_station_id: @station1.id, end_date: Date.tomorrow, end_station_id: @station2.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      @trip2 = @station1.trips.create(duration: 63, start_date: Date.today, start_station_id: @station1.id, end_date: Date.tomorrow, end_station_id: @station2.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      @trip3 = @station1.trips.create(duration: 63, start_date: Date.today, start_station_id: @station1.id, end_date: Date.tomorrow, end_station_id: @station2.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      @trip4 = @station1.trips.create(duration: 63, start_date: Date.today, start_station_id: @station2.id, end_date: Date.tomorrow, end_station_id: @station1.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      @trip5 = @station1.trips.create(duration: 63, start_date: Date.today, start_station_id: @station2.id, end_date: Date.tomorrow, end_station_id: @station1.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      @trip6 = @station1.trips.create(duration: 63, start_date: Date.today, start_station_id: @station2.id, end_date: Date.tomorrow, end_station_id: @station1.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
    end
    describe '.started_at' do
      it 'should show count that station shows up as a trips start station' do
        expect(@station1.started_at).to eq(3)
      end
    end

    describe '.ended_at' do
      it 'should show count that station shows up as a trips end station' do
        expect(@station1.ended_at).to eq(6)
      end
    end

    describe '.popular_end_station' do
      it 'should return the most frequent destination station (name) for a given start station' do
        expect(@station1.popular_end_station).to eq(@station1.name)
      end
    end

    describe '.popular_start_station' do
      it 'should return the most frequent start station (name) for a given end station' do
        expect(@station1.popular_start_station).to eq(@station2.name)
      end
    end

    describe '.popular_date' do
      it 'should return the Date with the highest number of trips started at this station' do
        expect(@station1.popular_date).to eq(@trip2.start_date)
      end
    end

    describe '.popular_zip' do
      it 'should return the Most frequent zip code for users starting trips at this station' do
        expect(@station1.popular_zip).to eq(@trip3.zip_code)
      end
    end

    describe '.popular_bike' do
      it 'should return the Most frequent bike for users starting trips at this station' do
        expect(@station2.popular_bike).to eq(@trip5.bike_id)
      end
    end
  end

  describe 'class methods' do
    before(:each) do
      date1 = Date.strptime("6/15/2010", '%m/%d/%Y')
      date23 = Date.strptime("6/15/2011", '%m/%d/%Y')
      date4 = Date.strptime("6/15/2012", '%m/%d/%Y')
      @station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins", installation_date: date1)
      @station2 = Station.create(name: 'Blake St', dock_count: 12, city: "Denver", installation_date: date23)
      @station3 = Station.create(name: 'State', dock_count: 11, city: "Denver", installation_date: date23)
      @station4 = Station.create(name: 'Market', dock_count: 10, city: "Denver", installation_date: date4)
      @trip1 = Trip.create(duration: 63, start_date: '8/28/2013 14:13', start_station_id: @station1.id, end_date: '8/29/2013 14:14', end_station_id: @station1.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
      @trip2 = Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: @station1.id, end_date: '8/29/2013 14:14', end_station_id: @station2.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94128)
      @trip3 = Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: @station1.id, end_date: '8/29/2013 14:14', end_station_id: @station2.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94128)
      @trip4 = Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: @station2.id, end_date: '8/29/2013 14:14', end_station_id: @station1.id, bike_id: 528, subscription_type: 'Subscriber', zip_code: 94127)
      @trip5 = Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: @station2.id, end_date: '8/29/2013 14:14', end_station_id: @station1.id, bike_id: 528, subscription_type: 'Subscriber', zip_code: 94127)
      @trip6 = Trip.create(duration: 63, start_date: '8/29/2013 14:13', start_station_id: @station2.id, end_date: '8/29/2013 14:14', end_station_id: @station2.id, bike_id: 520, subscription_type: 'Subscriber', zip_code: 94127)
    end

    describe 'self.total_count' do
      it 'returns the total station count' do
        expect(Station.total_count).to eq(4)
      end
    end

    describe 'self.average_bikes' do
      it 'returns the average # of bikes using station dock_count' do
        expect(Station.average_bikes).to eq(9)
      end
    end

    describe 'self.most_bikes' do
      it 'returns the station with the most bikes' do
        expect(Station.most_bikes.dock_count).to eq(12)
      end
    end

    describe 'self.top_stations_by_bike_count' do
      it 'returns the three stations with the highest bike counts' do
        expect(Station.top_stations_by_bike_count).to eq([@station2, @station3, @station4])
      end
    end

    describe 'self.bottom_stations_by_bike_count' do
      it 'returns the three stations with the lowest bike counts' do
        expect(Station.bottom_stations_by_bike_count).to eq([@station1, @station4, @station3])
      end
    end

    describe 'self.newest_station' do
      it 'returns the newest station by installation_date' do
        expect(Station.newest_station).to eq(@station4.name)
      end
    end

    describe 'self.oldest_station' do
      it 'returns the oldest station by installation_date' do
        expect(Station.oldest_station).to eq(@station1.name)
      end
    end
  end
end
