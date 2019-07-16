json.array!(@users) do |user|
  json.extract! user, :id, :name, :lastname, :email, :born_date, :genre
end
