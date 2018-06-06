require 'rails_helper'

describe 'Admin accessory pages' do
  it 'allows admin see all accessories' do
    admin = create(:user, role: 1)
    accessory = create(:accessory)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    click_on 'Accessories'

    expect(current_path).to eq('/admin/bike-shop')
    expect(page).to have_content(accessory.title)
    # expect(page).to have_content(accessory.thumbnail)
    expect(page).to have_content(accessory.description)
    expect(page).to have_button("Retire")
    expect(page).to have_link("Edit")
  end

  it 'allows admin to edit an accessory' do
    admin = create(:user, role: 1)
    accessory = create(:accessory)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_path

      click_on "Edit"

    expect(current_path).to eq(edit_admin_accessory_path(accessory))
  end

  it 'allows admin to update the status of an accesory' do
    admin = create(:user, role: 1)
    create(:accessory)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_path

      click_on "Retire"

    expect(current_path).to eq(admin_bike_shop_path)
    expect(page).to have_button('Reactivate')
  end
end
