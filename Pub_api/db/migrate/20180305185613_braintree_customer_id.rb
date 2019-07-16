class BraintreeCustomerId < ActiveRecord::Migration
  def change
	change_column :users, :braintree_customer_id, :string, limit: 256, null: true
  end
end
