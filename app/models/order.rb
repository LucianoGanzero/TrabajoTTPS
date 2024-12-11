class Order < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :size

  validates :quantity, numericality: { greater_than: 0 }

  def total
    product.unit_price * quantity
  end
end
