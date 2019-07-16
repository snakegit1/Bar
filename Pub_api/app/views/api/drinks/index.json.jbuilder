json.array!(@drinks) do |drink|
  json.extract! drink, :id, :name, :description, :enable
  json.drink_category drink.drink_category
end
