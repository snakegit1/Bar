class CreateDrinkCategories < ActiveRecord::Migration
  def change
    create_table :drink_categories do |t|
      t.string :name
      t.string :description
      t.timestamps null: false
    end

    add_belongs_to :drinks, :drink_category, index: true
  end
end
