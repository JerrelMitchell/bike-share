require 'rails_helper'

describe 'Admin accessory pages' do
  it 'allows admin see all accessories' do
    admin = create(:user, role: 1)
    create(:accessory)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_bike_shop_path

    click_button 'Retire'

    expect(page).to have_button('Reactivate')
  end
end
