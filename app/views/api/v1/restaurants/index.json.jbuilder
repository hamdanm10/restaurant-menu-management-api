json.status :success
json.data do
  json.restaurants do
    json.array! restaurants, partial: "restaurant", as: :restaurant
  end
end
json.pagination pagy.urls_hash
