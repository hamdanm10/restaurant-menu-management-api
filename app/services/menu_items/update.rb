# frozen_string_literal: true

class MenuItems::Update < ApplicationService
  def call(menu_item:, menu_item_params:)
    menu_item.assign_attributes(menu_item_params)

    if menu_item.save
      success(menu_item:)
    else
      failure(menu_item:)
    end
  end
end
