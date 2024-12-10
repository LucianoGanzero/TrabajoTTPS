class AddUserIdToSales < ActiveRecord::Migration[8.0]
  def change
    add_column :sales, :user_id, :integer
  end
end
