class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.references :pub
      t.float :price
      t.integer :status
      t.string :ip
      t.string :payment_method
      t.timestamps null: false
    end
  end
end
