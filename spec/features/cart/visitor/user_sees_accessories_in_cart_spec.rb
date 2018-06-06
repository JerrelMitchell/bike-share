require 'rails_helper'

describe 'User cart page' do
  it 'should display the information and price total of items in cart' do
    accessory = create(:accessory, price: 20, thumbnail: 'bike_horse.jpg')

    visit accessories_path

    within first("div.accessories") do
      click_on "Add to Cart"
    end

    within first("div.accessories") do
      click_on "Add to Cart"
    end

    within first("div.accessories") do
      click_on "Add to Cart"
    end

    visit cart_path

    expect(page).to have_content("$60.00")
    expect(page).to have_content(accessory.title)
    # expect(page).to have_content(accessory.thumbnail)
  end
end
