class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :phone
      t.string :password
      t.datetime :entry_date
      t.boolean :active

      t.timestamps
    end
  end
end
