require 'rails_helper'

describe 'User logged in and on dashboard page' do
  xit 'should display all orders' do
    accessory1 = create(:accessory, title: 'Pizza Cat', price: 50)
    accessory2 = create(:accessory, title: 'Pizza Cat', price: 50)
    accessory3 = create(:accessory, title: 'Brakes', price: 70)
    order1 = create(:order, status: 'Ordered', total_price: 170)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_dashboard_path(user)

    click_on 'View Order'

    expect(current_path).to eq(user_order_path(user))

    expect(page).to have_content(accessory1.title)
    expect(page).to have_content(accessory3.title)
    expect(page).to have_content(accessory1.price)
    expect(page).to have_content(accessory2.price)
    expect(page).to have_content(accessory3.price)
    expect(page).to have_content("#{accessory1.title} Subtotal: 100")
    expect(page).to have_content("#{accessory3.title} Subtotal: 70")
    expect(page).to have_content(order1.status)
    expect(page).to have_content(order1.total_price)
    expect(page).to have_content(order1.quantity)
    expect(page).to have_content(order1.created_at)
  end
end
