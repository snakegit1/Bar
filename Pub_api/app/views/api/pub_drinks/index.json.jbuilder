json.array!(@api_pub_drinks) do |pub_drink|
  json.extract! pub_drink, :id, :drink, :pub, :price, :enable
  json.drink_category pub_drink.drink.drink_category.name
  json.drink pub_drink.drink
end
