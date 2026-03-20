# frozen_string_literal: true

require "rails_helper"

RSpec.describe MenuItems::Create, type: :service do
  let!(:restaurant) { create(:restaurant) }

  let(:valid_params) {
    {
      restaurant_id: restaurant.id,
      name: "Menu A",
      description: "Description A",
      price: 10,
      category: :main,
      is_available: true
    }
  }


  let(:invalid_params) {
    {
      restaurant_id: nil,
      name: "",
      description: "",
      price: nil,
      category: :main,
      is_available: true
    }
  }

  describe "#call" do
    context "with valid params" do
      it "creates a menu_item and returns success" do
        result = described_class.call(restaurant:, menu_item_params: valid_params)

        expect(result).to be_success
        expect(result.payload[:menu_item]).to be_a(MenuItem)
        expect(result.payload[:menu_item].name).to eq("Menu A")
        expect(result.payload[:menu_item].restaurant_id).to eq(restaurant.id)
      end
    end

    context "with invalid params" do
      it "returns failure with the menu_item errors" do
        result = described_class.call(restaurant:, menu_item_params: invalid_params)

        expect(result).to be_failure
        expect(result.error[:menu_item]).to be_a(MenuItem)
        expect(result.error[:menu_item].errors).not_to be_empty
      end
    end
  end
end
