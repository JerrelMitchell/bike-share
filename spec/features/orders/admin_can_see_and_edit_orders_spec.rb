require 'rails_helper'

describe 'Admin logged in and on admin dashboard page' do
  xit 'should display all orders as orders' do
    accessory1 = create(:accessory, title: 'Pizza Cat', price: 50)
    accessory2 = create(:accessory, title: 'Pizza Cat', price: 50)
    accessory3 = create(:accessory, title: 'Brakes', price: 70)
    order1 = create(:order, status: 'Ordered', total_price: 170)
    user1 = create(:user)
    accessory4 = create(:accessory, title: 'Pizza Cat', price: 50)
    accessory5 = create(:accessory, title: 'Pizza Cat', price: 50)
    accessory6 = create(:accessory, title: 'Brakes', price: 70)
    order2 = create(:order, status: 'Ordered', total_price: 170)
    accessory7 = create(:accessory, title: 'Pizza Cat', price: 50)
    accessory8 = create(:accessory, title: 'Pizza Cat', price: 50)
    accessory9 = create(:accessory, title: 'Brakes', price: 70)
    order3 = create(:order, status: 'Paid', total_price: 170)
    user2 = create(:user)
    admin = User.create!(username: 'Sabrina', password: 'password', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on 'View Order 1'

    expect(page).to have_content("#{order1.status}(2)")

    expect(page).to have_link(order1.id)
    expect(page).to have_link(order2.id)
    expect(page).to have_link(order3.id)

    expect(page).to have_link('View Ordered')
    expect(page).to have_link('View Paid')
    expect(page).to have_link('View Cancelled')
    expect(page).to have_link('View Completed')

    click_on 'View Paid'

    expect(page).to have_link('Cancel')
    expect(page).to have_link('Mark as Completed')

    click on 'View Ordered'

    expect(page).to have_link('Cancel', count: 2)

    expect(page).to have_link('Mark as Paid', count: 2)

    expect(page).to have_content(accessory3.price)
  end
end
