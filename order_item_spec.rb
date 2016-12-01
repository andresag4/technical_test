require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end

  context 'methods' do
    let(:product_valid_attributes) { {name: 'Milk', price: 17.4} }

    before :each do
      @duty_category = DutyCategory.create(tax_rate: 20.0)
      @product = @duty_category.products.create(product_valid_attributes)
      @order_item = Order.create.order_items.create(product_id: @product.id, quantity: 3)
    end

    it 'should get the total price of the product' do
      expect(@order_item.total_price).to eq(@order_item.quantity * @order_item.product.price)
    end

    it 'should get the total price of the product in YUAN' do
      expect(@order_item.decorate_total_price_with_currency_yuan).
          to eq(@order_item.quantity * @order_item.product.price * 7.29)
    end

    it 'should get the product tax' do
      expect(@order_item.get_product_tax).
          to eq(@order_item.total_price * @order_item.product.duty_category.tax_rate / 100)
    end

    it 'should get the product tax in YUAN' do
      expect(@order_item.get_product_yuan_tax).
          to eq(@order_item.decorate_total_price_with_currency_yuan * @order_item.product.duty_category.tax_rate / 100)
    end
  end
end
