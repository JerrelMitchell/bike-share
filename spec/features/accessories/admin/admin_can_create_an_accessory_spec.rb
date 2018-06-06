require 'rails_helper'

describe 'Admin new accessory page' do
  it 'Allows admin to create an accessory' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_accessory_path

    fill_in 'accessory[title]', with: 'something meow'
    fill_in 'accessory[description]', with: 'good stuff'
    fill_in 'accessory[price]', with: 45
    fill_in 'accessory[thumbnail]', with: 'bike_horse.jpg'

    click_button 'Create Accessory'

    expect(current_path).to eq(admin_bike_shop_path)
    expect(page).to have_content('something meow')
    expect(page).to have_content('Edit')
    expect(page).to have_button('Retire')
  end
end
