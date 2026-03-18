json.status :success
json.data do
  json.menu_item do
    json.partial! "menu_item", menu_item: menu_item
  end
end
