class CreateSizeStocks < ActiveRecord::Migration[8.0]
  def change
    create_table :size_stocks do |t|
      t.integer :stock_available
      t.belongs_to :product, index: true
      t.belongs_to :size, index: true
      t.timestamps
    end
  end
end
