require 'rails_helper'

describe 'Admin accessories index page' do
  context 'as admin' do
    it 'allows admin to see all accessories' do

	    admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      accessory = create(:accessory)

      visit admin_bike_shop_path

      expect(page).to have_content('Admin Accessories')
      expect(page).to have_content(accessory.title)
      expect(page).to have_content(accessory.description)
      # expect(page).to have_content(accessory.thumbnail)
      expect(page).to have_content('Edit')
      expect(page).to have_button('Retire')
    end
  end
end
