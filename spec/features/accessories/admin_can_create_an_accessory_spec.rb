require 'rails_helper'

describe 'Admin accessory pages' do
  it 'allows admin see all accessories' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    click_on 'Accessories'

    expect(current_path).to eq('/admin/bike-shop')
  end
end

describe 'Admin new accessory page' do
  xit 'Allows admin to create an accessory' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    accessory = create(:accessory,
                      title: 'handlebar streamer',
                      description: 'Cool',
                      price: 5,
                      thumbnail: 'streamer.jpg')

    visit new_admin_accessory_path

    fill_in 'accessory[title]', with: accessory.title
    fill_in 'accessory[description]', with: accessory.description
    fill_in 'accessory[price]', with: accessory.price
    fill_in 'accessory[thumbnail]', with: accessory.thumbnail

    # within('#create_accessory') do
    #   fill_in 'accessory[title]', with: accessory.title
    #   fill_in 'accessory[description]', with: accessory.description
    #   fill_in 'accessory[price]', with: accessory.price
    #   fill_in 'accessory[thumbnail]', with: accessory.thumbnail
      click_button 'Create Accessory'
    # end

    expect(current_path).to eq(admin_bike_shop_path)
    expect(page).to have_content(accessory.title)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content(accessory.price)
    expect(page).to have_content(accessory.thumbnail)
  end
end
