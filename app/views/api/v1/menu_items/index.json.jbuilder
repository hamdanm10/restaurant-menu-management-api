json.status :success
json.data do
  json.menu_items do
    json.array! menu_items, partial: "menu_item", as: :menu_item
  end
end
json.pagination pagy.urls_hash
