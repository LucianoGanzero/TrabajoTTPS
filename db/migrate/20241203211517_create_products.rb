class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :unit_price
      t.datetime :entry_date
      t.datetime :deactivation_date

      t.timestamps
    end

    create_table :products_categories, id: false do |t|
      t.belongs_to :products, index: true
      t.belongs_to :categories, index: true
    end


    create_table :products_colors, id: false do |t|
      t.belongs_to :products, index: true
      t.belongs_to :colors, index: true
    end
  end
end
