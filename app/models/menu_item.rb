# frozen_string_literal: true

class MenuItem < ApplicationRecord
  # ====================
  # Enums
  # ====================
  enum :category, {
    appetizer: 0,
    main: 1,
    dessert: 2,
    drink: 3
  }

  # ====================
  # Relations
  # ====================
  belongs_to :restaurant

  # ====================
  # Validations
  # ====================
  validates :name,
            presence: true,
            uniqueness: { scope: :restaurant_id },
            length: { maximum: 150 }
  validates :description, length: { maximum: 1000 }, allow_blank: true
  validates :price,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }
  validates :is_available,
            inclusion: { in: [ true, false ] }
end
