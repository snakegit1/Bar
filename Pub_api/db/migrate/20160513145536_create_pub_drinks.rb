class CreatePubDrinks < ActiveRecord::Migration
  def change
    create_table :pub_drinks do |t|
      t.integer :price
      t.string :description
      t.belongs_to :drink 
      t.belongs_to :pub 
      t.timestamps null: false
    end
  end
end
