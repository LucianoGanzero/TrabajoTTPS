class RenameCategoriesSizesColumns < ActiveRecord::Migration[8.0]
  def change
    rename_column :categories_sizes, :categories_id, :category_id
    rename_column :categories_sizes, :sizes_id, :size_id
  end
end
