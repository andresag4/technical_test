require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:product) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_uniqueness_of(:product_id) }

    context 'when quantity is valid' do
      it { is_expected.to allow_value(1).for(:quantity) }
    end

    context 'when quantity is invalid' do
      it { is_expected.to_not allow_value(0).for(:quantity) }
      it { is_expected.to_not allow_value(-1).for(:quantity) }
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  context 'methods' do
    context 'without records' do
      it 'the total should be 0 if there are no products in the cart' do
        expect(Cart.get_total).to eq(0)
      end
    end

    context 'with records' do
      let(:valid_attributes) { {name: 'Milk', tag: 'mi54', price: 17.4} }

      before :each do
        @product = Product.create(valid_attributes)
        Cart.create(product_id: @product.id, quantity: 3)
      end

      it 'the total should be equal to the quantity multiplied by the products prices' do
        total = 0

        Cart.all.each do |cart|
          total += cart.product_price.round / 100.0 * cart.quantity
        end

        expect(total).to be Cart.get_total
      end

      it 'should get the total tax' do
        expect(Cart.get_total_tax).to eq(Cart.get_total * 0.15)
      end

      it 'should get the subtotal' do
        expect(Cart.get_total).to eq(Cart.get_total * 0.85)
      end

      it 'should be equal the tax plus the subtotal to the total' do
        expect(Cart.get_total_tax + Cart.get_subtotal).to eq(Cart.get_total)
      end
    end
  end
end
