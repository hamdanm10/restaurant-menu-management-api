# frozen_string_literal: true

class MenuItems::Create < ApplicationService
  def call(restaurant:, menu_item_params:)
    menu_item = restaurant.menu_items.new(menu_item_params)

    if menu_item.save
      success(menu_item:)
    else
      failure(menu_item:)
    end
  end
end
