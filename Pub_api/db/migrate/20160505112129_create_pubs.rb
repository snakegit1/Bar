class CreatePubs < ActiveRecord::Migration
  def change
    create_table :pubs do |t|
      t.string :name
      t.string :description
      t.string :telephone1
      t.string :telephone2
      t.string :location

      t.timestamps null: false
      t.belongs_to :users, index: true
    end
  end
end
