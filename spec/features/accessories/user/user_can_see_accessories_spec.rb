require 'rails_helper'

describe 'Vistor sees /bike-shop' do
  it 'displays 12 accessories per page' do
    create_list(:accessory, 11)

    accessory = create(:accessory) #this is 12

    visit '/bike-shop'

    expect(page).to have_content(accessory.title)
    expect(page).to have_css('div.accessories', count: 12)
    expect(page).to have_button("Add to Cart", count: 12)
    expect(page).to have_link("View Details", count: 12)
  end
end
