class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :details
      t.attachment :image
      
      t.timestamps null: false
    end
  end
end
