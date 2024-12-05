class RenameProductsCategoriesToCategoriesProducts < ActiveRecord::Migration[8.0]
  def change
    rename_table :products_categories, :categories_products
  end
end
