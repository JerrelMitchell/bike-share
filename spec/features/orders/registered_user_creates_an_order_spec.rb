require 'rails_helper'

describe 'registered user index page' do
  describe 'user adds item to cart' do
        describe 'user clicks on check out' do
        it 'should create a new order' do
        user1 = User.create(username: "penelop", password: "boom", role: 0)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
        accessory = Accessory.create(title: 'cat dog', description: 'Delicious!', thumbnail: 'bike_horse.jpg', price: 10 )
        order = user1.orders.create!()
        AccessoryOrder.create(order_id: user1.id, accessory_id:accessory.id)
        AccessoryOrder.create(order_id: user1.id, accessory_id:accessory.id)
        AccessoryOrder.create(order_id: user1.id, accessory_id:accessory.id)
        AccessoryOrder.create(order_id: user1.id, accessory_id:accessory.id)

        visit accessory_path(accessory)
        4.times do
          click_on "Add to Cart"
        end
        visit cart_path

        click_on 'Check Out'

        expect(page).to have_content("Order ID: #{order.id}")
      end
    end
  end
end