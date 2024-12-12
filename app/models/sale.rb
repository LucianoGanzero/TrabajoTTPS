class Sale < ApplicationRecord
  has_many :product_solds
  belongs_to :salesman, class_name: "User", optional: true

  def update_total_price
    self.total_price = product_solds.sum(&:total)
    logger.debug "Actualizando total_price: #{self.total_price}"
    save!
  end
end
