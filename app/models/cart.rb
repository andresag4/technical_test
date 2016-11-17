class Cart < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :product, :quantity
  validates_numericality_of :quantity, greater_than: 0
  validates_uniqueness_of :product_id

  delegate :price, to: :product, prefix: true


  def self.get_total_tax
    self.get_total * 0.15
  end

  def self.get_subtotal
    self.get_total * 0.85
  end

  def self.get_total
    total = 0

    Cart.all.each do |cart|
      total += cart.product_price.round / 100.0 * cart.quantity
    end

    total.round
  end
end
