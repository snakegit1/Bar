json.extract! @pub, :id, :name, :location, :enable, :description, :telephone1, :telephone2, :created_at, :updated_at, :bank_account_rut, :bank_name, :bank_account_type, :bank_account_number, :bank_account_email, :bank_account_number, :order_index
json.image_logo URI.join("http://api.box-free.com/", @pub.image_logo.url(:thumb)).to_s
json.pub_drinks @pub.pub_drinks
