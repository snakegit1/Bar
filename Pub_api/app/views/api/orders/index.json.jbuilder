json.array!(@orders) do |order|
  json.extract! order, :id, :price, :status, :token, :ip, :token, :payment_method, :created_at
  json.status_traslated (order.status) ? "Sí" : "No"
  json.user order.user, :id, :email, :name, :lastname, :born_date, :genre, :braintree_customer_id
  json.pub order.pub
  json.pub_image URI.join("http://api.box-free.com/", order.pub.image_logo.url(:thumb).to_s).to_s
  json.drinks order.get_drinks
  json.created_at_formated order.created_at.strftime("%F %T")
  json.updated_at_formated (order.status) ? order.updated_at.strftime("%F %T") : ""
  json.payment @payment
end
