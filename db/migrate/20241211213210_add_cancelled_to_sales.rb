class AddCancelledToSales < ActiveRecord::Migration[8.0]
  def change
    add_column :sales, :cancelled, :boolean, default: false, null: false
    add_column :sales, :cancel_date, :datetime, null: true
  end
end
