class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.references :user
      t.string :token
      t.timestamps null: false
    end
  end
end
