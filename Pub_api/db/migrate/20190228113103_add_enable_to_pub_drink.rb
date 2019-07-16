class AddEnableToPubDrink < ActiveRecord::Migration
  def change
    add_column :pub_drinks, :enable, :boolean, default: true
  end
end
