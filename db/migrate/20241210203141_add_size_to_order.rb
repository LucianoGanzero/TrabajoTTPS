class AddSizeToOrder < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :size, null: false, foreign_key: true
  end
end
