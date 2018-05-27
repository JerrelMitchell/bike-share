require 'rails_helper'

describe 'visitor' do
  context 'visits stations index page' do
    it 'should see a list of stations with all attributes' do

      station1 = Station.create(name: 'Fort Collins Downtown', dock_count: 5, city: "Fort Collins", installation_date: "01/18/2015")
      station2 = Station.create(name: 'Blake St', dock_count: 10, city: "Denver", installation_date: "02/22/2013")
      station3 = Station.create(name: 'Larimer St', dock_count: 2, city: "Denver", installation_date: "07/18/2018")

      
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
  end
end