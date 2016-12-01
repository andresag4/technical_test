require 'rails_helper'
require 'tax_and_duty_price'

RSpec.describe TaxAndDutyPrice, type: :class do
  let(:product_valid_attributes) { {name: 'Milk', price: 17.43} }
  let(:product_valid_attributes_2) { {name: 'Lemonade', price: 8.91} }

  before :each do
    @duty_category = DutyCategory.create(tax_rate: 20.0)
    @product = @duty_category.products.create(product_valid_attributes)
    @duty_category_2 = DutyCategory.create(tax_rate: 15.0)
    @product_2 = @duty_category_2.products.create(product_valid_attributes_2)

    @order = Order.create
    @order.order_items.create(product_id: @product.id, quantity: 2)
    @order.order_items.create(product_id: @product_2.id, quantity: 4)
  end

  context 'methods' do
    it 'should return the total price' do
      expect(TaxAndDutyPrice.new(@order).price).to eq(get_price)
    end

    it 'should return the total price in YUAN' do
      expect(TaxAndDutyPrice.new(@order).yuan_price).to eq(get_yuan_price)
    end

    it 'should return the 0 when the order is less than 50 YUAN' do
      @duty_category = DutyCategory.create(tax_rate: 10.0)
      @product = @duty_category.products.create(name: 'Lemonade', price: 0.51)
      @order = Order.create
      @order.order_items.create(product_id: @product.id, quantity: 1)

      expect(TaxAndDutyPrice.new(@order).price).to eq(0)
    end

  end

  private

  def get_price
    total = 0

    @order.order_items.each { |order_item| total += order_item.total_price + order_item.get_product_tax }

    get_yuan_price < 50 ? 0 : total
  end

  def get_yuan_price
    total = 0

    @order.order_items.each { |order_item| total += order_item.decorate_total_price_with_currency_yuan + order_item.get_product_yuan_tax }

    total
  end
end
