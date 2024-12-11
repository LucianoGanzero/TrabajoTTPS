class ProductSold < ApplicationRecord
  belongs_to :product
  belongs_to :sale
  belongs_to :size

  validates :quantity, numericality: { greater_than: 0 }

  def total
    sell_price * quantity
  end
end
