class Gifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.references :user, index: true
      t.references :drink, index: true
      t.references :pub, index: true
      t.string :gift_name
      t.column :status, :integer, default: 0
    end
  end

  def self.down
    drop_table :gifts
  end
end
