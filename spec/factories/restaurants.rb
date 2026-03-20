# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant do
    name { "Test Restaurant" }
    address { "Test Address" }
    phone { "+661234567890" }
    opening_hours { "Mon-Sun 09:00-23:00" }
  end
end
