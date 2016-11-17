class Product < ActiveRecord::Base
  has_many :carts, dependent: :destroy

  validates_presence_of :name, :tag, :price
  validates_uniqueness_of :tag
  validates_format_of :tag, with: /[A-Za-z]{2}[0-9]{2}/

  def get_tax
    self.price * 0.15
  end
end
