class CreateProductSolds < ActiveRecord::Migration[8.0]
  def change
    create_table :product_solds do |t|
      t.decimal :sell_price
      t.integer :quantity
      t.belongs_to :product, index: true
      t.belongs_to :sale, index: true

      t.timestamps
    end
  end
end
