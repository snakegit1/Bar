json.array!(@gifts) do |gift|
  json.id gift.id
  json.user_id gift.user_id
  json.pub_id gift.pub.id
  json.drink_id gift.drink_id
  json.drink_name gift.drink.name
end
