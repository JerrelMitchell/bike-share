require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({"1" => 2, "2" => 3}) }

  describe "#total_count" do
    it "calculates the total number of accessories it holds" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_accessory" do
    it "adds an accessory to its contents" do
      subject.add_item_cart(1)
      subject.add_item_cart(2)

      expect(subject.contents).to eq({"1"=>3, "2"=>4})
    end
  end

  describe "#count_of" do
    it "reports how many of a particular accessory" do
      expect(subject.count_of(1)).to eq(2)
      expect(subject.count_of(2)).to eq(3)
    end
  end
end
