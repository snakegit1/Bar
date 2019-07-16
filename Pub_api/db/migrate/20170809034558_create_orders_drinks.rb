class CreateOrdersDrinks < ActiveRecord::Migration
  def change
    create_table :orders_drinks do |t|
      t.references :order
      t.references :drink
      t.float :price
      t.float :quantity
      t.timestamps null: false
    end
  end
end
