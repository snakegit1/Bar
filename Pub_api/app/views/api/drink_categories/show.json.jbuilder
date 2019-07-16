json.extract! @drink_category, :id, :name, :enable
json.drinks @drink_category.drinks if @include_drinks
