class OrdersStatusIsBoolean < ActiveRecord::Migration
  def change
	change_column :orders, :status, :boolean, default: false, null: true
  end
end
