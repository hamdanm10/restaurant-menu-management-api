# frozen_string_literal: true

FactoryBot.define do
  factory :menu_item do
    sequence(:name) { |n| "Test Menu #{n}" }
    description { "Test Description" }
    price { 10 }
    category { "main" }
    is_available { true }

    association :restaurant
  end
end
