# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :menu_items, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :phone,
            format: { with: /\A\+[1-9]\d{7,14}\z/ },
            allow_blank: true
  validates :opening_hours, length: { maximum: 100 }, allow_blank: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name address phone]
  end
end
