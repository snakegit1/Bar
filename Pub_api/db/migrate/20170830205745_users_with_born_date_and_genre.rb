class UsersWithBornDateAndGenre < ActiveRecord::Migration
  def change
    add_column :users, :born_date, :date, required: false
    add_column :users, :genre, :string, limit: 1, required: false
  end
end
