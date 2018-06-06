require 'rails_helper'

describe 'visitor' do
  context 'admin stations index page' do
    it 'should see a list of stations with all attributes' do
      admin = User.create(username: "penelope", password: "boom", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins")
      station2 = Station.create(name: 'Blake St', dock_count: 10, city: "Denver")
      station3 = Station.create(name: 'Larimer St', dock_count: 2, city: "Denver")


      visit stations_path

      expect(page).to have_content(station1.name)
      expect(page).to have_content(station2.name)
      expect(page).to have_content(station3.name)
      expect(page).to have_content(station1.dock_count)
      expect(page).to have_content(station2.dock_count)
      expect(page).to have_content(station3.dock_count)
      expect(page).to have_content(station1.city)
      expect(page).to have_content(station2.city)
      expect(page).to have_content(station3.city)
      expect(page).to have_content(station1.installation_date)
      expect(page).to have_content(station2.installation_date)
      expect(page).to have_content(station3.installation_date)
    end

    it 'should see an edit button next to each station' do
      admin = User.create(username: "penelope", password: "boom", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins")

      visit stations_path

      click_link('Edit')

      expect(current_path).to eq(edit_admin_station_path(station1))
    end

    it 'should update and redirect to station show page' do
      admin = User.create(username: "penelope", password: "boom", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name: 'China', dock_count: 5, city: "Fort Collins")
      date = Date.strptime("6/15/2012", '%m/%d/%Y')

      visit edit_admin_station_path(station)

      fill_in 'station[name]', with: 'LaFox'
      fill_in 'station[dock_count]', with: '11'
      fill_in 'station[city]', with: 'Campton Hills'
      fill_in 'station[installation_date]', with: date
      click_button 'Update Station'

      expect(current_path).to eq("/station/LaFox")

      expect(page).to have_content('LaFox')
      expect(page).to have_content('Campton')
      expect(page).to have_content('11')
      expect(page).to have_content(date)
    end

    it 'should see an delete button next to each station' do
      admin = User.create(username: "penelope", password: "boom", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins")

      visit stations_path

      expect(page).to have_link('Edit')

      click_link('Delete')

      expect(current_path).to eq(stations_path)
    end
  end
end
