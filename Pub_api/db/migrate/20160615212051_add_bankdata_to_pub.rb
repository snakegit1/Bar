class AddBankdataToPub < ActiveRecord::Migration
  def change
    add_column :pubs, :bank_name, :string
    add_column :pubs, :bank_account_type, :string
    add_column :pubs, :bank_account_number, :string
    add_column :pubs, :bank_account_rut, :string
    add_column :pubs, :bank_account_email, :string
  end
end
