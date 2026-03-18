# frozen_string_literal: true

class MenuItem < ApplicationRecord
  enum :category, {
    appetizer: 0,
    main: 1,
    dessert: 2,
    drink: 3
  }

  belongs_to :restaurant

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
  validates :category,
            presence: true,
            inclusion: { in: categories.keys }
  validates :is_available, inclusion: { in: [ true, false ] }

  def self.ransackable_attributes(auth_object = nil)
    %w[name description category is_available]
  end

  ransacker :category, formatter: proc { |value|
    categories[value] || value
  } do |parent|
    parent.table[:category]
  end
end
