class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def get_product_tax
    self.total_price * self.product.duty_category.tax_rate / 100
  end

  def get_product_yuan_tax
    self.decorate_total_price_with_currency_yuan * self.product.duty_category.tax_rate / 100
  end

  def total_price
    self.quantity * self.product.price
  end

  def decorate_total_price_with_currency_yuan
    self.quantity * self.product.price * 7.29
  end
end
