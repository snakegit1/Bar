class AddEnableFieldToPub < ActiveRecord::Migration
  def change
    add_column :drink_categories, :enable, :boolean, default: true
    add_column :pubs, :enable, :boolean, default: true
    add_column :drinks, :enable, :boolean, default: true
  end
end
