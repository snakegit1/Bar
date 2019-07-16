class AddOrderInPub < ActiveRecord::Migration
  def change
    add_column :pubs, :order_index, :integer
  end
end
