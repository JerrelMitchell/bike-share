require 'rails_helper'


RSpec.describe Order, type: :model do
  context 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    before(:each) do
      user = User.create(username: "penelop", password: "boom", role: 0)
      @order = user.orders.create()
      accessory1 = @order.accessories.create(title: 'tire', description: 'Delicious!', thumbnail: 'bike_horse.jpg', price: 10 )
      accessory2 = @order.accessories.create(title: 'chain', description: 'Delicious!', thumbnail: 'bike_horse.jpg', price: 10 )
      accessory3 = @order.accessories.create(title: 'handle bars', description: 'Delicious!', thumbnail: 'bike_horse.jpg', price: 10 )
    end
    context 'total_price' do
      it 'should return the order total based on purchased accessories' do
        expect(@order.total_price).to eq(30)
      end

      describe 'relationships' do
        it { should belong_to(:user) }
        it { should have_many(:accessories) }
        it { should have_many(:accessory_orders)}
      end
    end
  end
end
