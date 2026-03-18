# frozen_string_literal: true

class Restaurants::Create < ApplicationService
  def call(restaurant_params:)
    restaurant = Restaurant.new(restaurant_params)

    if restaurant.save
      success(restaurant:)
    else
      failure(restaurant:)
    end
  end
end
