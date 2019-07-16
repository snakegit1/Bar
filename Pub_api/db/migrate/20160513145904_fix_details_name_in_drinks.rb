class FixDetailsNameInDrinks < ActiveRecord::Migration
  def change
  	rename_column :drinks, :details, :description
  end
end
