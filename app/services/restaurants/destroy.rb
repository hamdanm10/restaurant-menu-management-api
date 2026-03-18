# frozen_string_literal: true

class Restaurants::Destroy < ApplicationService
  def call(restaurant:)
    restaurant.destroy
    success(nil)
  end
end
