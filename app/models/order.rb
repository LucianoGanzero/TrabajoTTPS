class Order < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :size

  def total
    product.unit_price * quantity
  end
end
