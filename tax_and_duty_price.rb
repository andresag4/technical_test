class TaxAndDutyPrice
  def initialize(order)
    @order = order
  end

  def price
    total = 0

    @order.order_items.each { |order_item| total += order_item.total_price + order_item.get_product_tax }

    yuan_price < 50 ? 0 : total
  end

  def yuan_price
    total = 0

    @order.order_items.each { |order_item| total += order_item.decorate_total_price_with_currency_yuan + order_item.get_product_yuan_tax }

    total
  end
end
