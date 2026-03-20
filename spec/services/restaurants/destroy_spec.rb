# frozen_string_literal: true

require "rails_helper"

RSpec.describe Restaurants::Destroy, type: :service do
  let!(:restaurant) { create(:restaurant) }

  describe "#call" do
    it "destroys the restaurant and returns success" do
      result = described_class.call(restaurant: restaurant)

      expect(result).to be_success
      expect(Restaurant.exists?(restaurant.id)).to be_falsey
    end
  end
end
