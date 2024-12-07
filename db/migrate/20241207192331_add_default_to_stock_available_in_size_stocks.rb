class AddDefaultToStockAvailableInSizeStocks < ActiveRecord::Migration[8.0]
  def change
    change_column_default :size_stocks, :stock_available, 0
  end
end
