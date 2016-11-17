require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:tag) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_uniqueness_of(:tag) }

    context 'when tag format is valid' do
      it { is_expected.to allow_value('ab12').for(:tag) }
    end

    context 'when tag format is invalid' do
      it { is_expected.to_not allow_value('abcd').for(:tag) }
    end
  end

  context 'associations' do
    it { is_expected.to have_many(:carts).dependent(:destroy) }
  end

  context 'methods' do
    let(:valid_attributes) { {name: 'Milk', tag: 'mi54', price: 17.4} }

    before :each do
      @product = Product.new(valid_attributes)
    end

    it 'should get the tax' do
      expect(@product.get_tax).to eq(@product.price * 0.15)
    end
  end
end
