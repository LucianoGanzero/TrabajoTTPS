class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.decimal :total_price
      t.string :client

      t.timestamps
    end
  end
end