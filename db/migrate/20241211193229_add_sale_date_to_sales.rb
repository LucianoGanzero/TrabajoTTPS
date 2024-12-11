class AddSaleDateToSales < ActiveRecord::Migration[8.0]
  def change
    add_column :sales, :sale_date, :datetime
  end
end
