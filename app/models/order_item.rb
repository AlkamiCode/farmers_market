class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  validates :quantity, numericality: { greater_than: 0 }
  before_create :create_unit_price

  def create_unit_price
    self.unit_price = self.product.price
  end

  def subtotal
    unit_price * quantity
  end
end
