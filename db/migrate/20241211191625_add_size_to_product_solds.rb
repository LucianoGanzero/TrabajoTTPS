class AddSizeToProductSolds < ActiveRecord::Migration[8.0]
  def change
    add_reference :product_solds, :size, null: false, foreign_key: true
  end
end
