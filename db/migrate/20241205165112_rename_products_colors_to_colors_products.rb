class RenameProductsColorsToColorsProducts < ActiveRecord::Migration[8.0]
  def change
    rename_table :products_colors, :colors_products
  end
end
