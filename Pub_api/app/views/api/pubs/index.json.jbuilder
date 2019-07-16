json.array!(@pubs) do |pub|
  json.extract! pub, :id, :name, :description, :location, :enable, :telephone1, :telephone2, :bank_account_rut, :bank_name, :bank_account_type, :bank_account_number, :bank_account_email, :bank_account_number, :order_index
  json.image_logo URI.join("http://api.box-free.com/", pub.image_logo.url(:thumb)).to_s
  json.pub_drinks pub.pub_drinks
  json.user_id pub.user_id if (current_user.admin? || current_user.super_admin?)
end
