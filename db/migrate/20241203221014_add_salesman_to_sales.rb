class AddSalesmanToSales < ActiveRecord::Migration[8.0]
  def change
    add_reference :sales, :salesman, foreign_key: { to_table: :users }, null: false
  end
end
