require 'rails_helper'

describe 'Unregistered user index page' do
  describe 'allows user to add items to cart' do
    it 'displays contents in cart' do
      accessory = create(:accessory)

      visit accessory_path(accessory)

      click_on "Add to Cart"

      visit cart_path

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(accessory.title)
      expect(page).to have_content(accessory.price)
      # expect(page).to have_content(accessory.thumbnail)
      expect(Accessory.all.count).to eq(1)
      expect(page).to have_button("Remove")
      expect(page).to have_link("Check Out")
    end
  end
end

describe 'Cart index page' do
  it 'allows user to delete accessory' do
    accessory = create(:accessory)

    visit accessory_path(accessory)

    click_on "Add to Cart"

    visit cart_path

    click_on 'Remove'

    expect(page).to have_content("Successfully removed #{accessory.title} from your cart.")
    expect(page).to_not have_content(accessory.thumbnail)
  end
end

describe 'Cart index page' do
  it 'allows registered user to check out' do
    user1 = User.create(username: "penelop", password: "boom", role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
    accessory = Accessory.create(title: 'cat dog', description: 'Delicious!', thumbnail: 'bike_horse.jpg', price: 10 )
    order = user1.orders.create!(status:rand(0..3))
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

    expect(page).to have_content("Successfully submitted your order totaling: $#{order.total_price}")
  end
end
