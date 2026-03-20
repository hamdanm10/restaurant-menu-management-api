# frozen_string_literal: true

require "rails_helper"

RSpec.describe Restaurants::Update, type: :service do
  let!(:restaurant) { create(:restaurant, name: "Old Name") }
  let(:valid_params) { { name: "New Name" } }
  let(:invalid_params) { { name: "" } }

  describe "#call" do
    context "with valid params" do
      it "updates the restaurant and returns success" do
        result = described_class.call(restaurant: restaurant, restaurant_params: valid_params)

        expect(result).to be_success
        expect(result.payload[:restaurant].name).to eq("New Name")
      end
    end

    context "with invalid params" do
      it "returns failure with the restaurant errors" do
        result = described_class.call(restaurant: restaurant, restaurant_params: invalid_params)

        expect(result).to be_failure
        expect(result.error[:restaurant]).to eq(restaurant)
        expect(result.error[:restaurant].errors).not_to be_empty
      end
    end
  end
end
