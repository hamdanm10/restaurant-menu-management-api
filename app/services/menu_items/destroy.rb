# frozen_string_literal: true

class MenuItems::Destroy < ApplicationService
  def call(menu_item:)
    menu_item.destroy
    success(nil)
  end
end
