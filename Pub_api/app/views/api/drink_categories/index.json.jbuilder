#json.array!(@drink_categories) do |drink_category|
#  json.extract! drink_category, :id, :name, :enable
#  json.drinks drink_category.drinks if @include_drinks
#end


json.array!(@drink_categories) do |drink_category|
  json.extract! drink_category, :id, :name, :enable
  json.drinks drink_category.drinks do |drink| if @include_drinks
    json.image_url drink.image.url(:medium)
    json.name drink.name
    json.id drink.id
    json.enable drink.enable
  end
  #drink_category.drinks
end
end
