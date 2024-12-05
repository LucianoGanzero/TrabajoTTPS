class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :categories_sizes, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :size, index: true
    end
  end
end
