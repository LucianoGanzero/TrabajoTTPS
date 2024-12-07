class AddDeactivatedToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :deactivated, :boolean, default: false
  end
end
