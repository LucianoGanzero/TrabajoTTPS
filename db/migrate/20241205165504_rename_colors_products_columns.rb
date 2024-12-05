class RenameColorsProductsColumns < ActiveRecord::Migration[8.0]
  def change
    rename_column :colors_products, :colors_id, :color_id
    rename_column :colors_products, :products_id, :product_id
  end
end
