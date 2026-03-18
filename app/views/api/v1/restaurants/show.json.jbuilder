json.status :success
json.data do
  json.restaurant do
    json.partial! "restaurant", restaurant: restaurant

    json.menu_items restaurant.menu_items do |menu_item|
      json.id menu_item.id
      json.name menu_item.name
      json.description menu_item.description
      json.price menu_item.price
      json.category menu_item.category
      json.is_available menu_item.is_available?
      json.created_at menu_item.created_at
      json.updated_at menu_item.updated_at
    end
  end
end
