json.status :success
json.data do
  json.restaurant do
    json.partial! "restaurant", restaurant: restaurant
  end
end
