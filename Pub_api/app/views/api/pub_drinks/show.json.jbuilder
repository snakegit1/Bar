json.extract! @api_pub_drink, :id, :drink, :pub, :price, :created_at, :updated_at, :enable
json.drink_category @api_pub_drink.drink.drink_category.name