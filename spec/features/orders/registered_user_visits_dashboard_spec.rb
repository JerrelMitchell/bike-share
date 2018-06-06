require 'rails_helper'

describe 'registered user' do
  before(:each) do
      user = User.create(username: "penelop", password: "boom", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      @order = user.orders.create()
      accessory1 = @order.accessories.create(title: 'tire', description: 'Delicious!', thumbnail: 'bike_horse.jpg', price: 10 )
      accessory2 = @order.accessories.create(title: 'chain', description: 'Delicious!', thumbnail: 'bike_horse.jpg', price: 10 )
      accessory3 = @order.accessories.create(title: 'handle bars', description: 'Delicious!', thumbnail: 'bike_horse.jpg', price: 10 )
    end
  context 'visits dashboard' do
    it 'should show all orders' do

      visit '/dashboard'
      expect(page).to have_content(@order.total_price)
      expect(page).to have_content(@order.status)
      expect(page).to have_content(@order.id)
      expect(page).to have_content(@order.accessories.count)
    end
  end
end
