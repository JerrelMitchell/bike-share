require 'rails_helper'

describe Accessory, type: :model do
  context 'validations' do
    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:price) }
  end
end
