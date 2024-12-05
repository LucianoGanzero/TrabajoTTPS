class RenameProductsCategoriesColumns < ActiveRecord::Migration[8.0]
  def change
    rename_column :products_categories, :categories_id, :category_id
    rename_column :products_categories, :products_id, :product_id
  end
end
