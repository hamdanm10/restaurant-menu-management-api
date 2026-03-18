# frozen_string_literal: true

class Restaurants::Update < ApplicationService
  def call(restaurant:, restaurant_params:)
    restaurant.assign_attributes(restaurant_params)

    if restaurant.save
      success(restaurant:)
    else
      failure(restaurant:)
    end
  end
end
