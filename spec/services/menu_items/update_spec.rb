# frozen_string_literal: true

require "rails_helper"

RSpec.describe MenuItems::Update, type: :service do
  let(:restaurant) { create(:restaurant) }
  let!(:menu_item) { create(:menu_item, restaurant:, name: "Old Name") }
  let(:valid_params) { { name: "New Name" } }
  let(:invalid_params) { { name: "" } }

  describe "#call" do
    context "with valid params" do
      it "updates the menu_item and returns success" do
        result = described_class.call(menu_item: menu_item, menu_item_params: valid_params)

        expect(result).to be_success
        expect(result.payload[:menu_item].name).to eq("New Name")
      end
    end

    context "with invalid params" do
      it "returns failure with the menu_item errors" do
        result = described_class.call(menu_item: menu_item, menu_item_params: invalid_params)

        expect(result).to be_failure
        expect(result.error[:menu_item]).to eq(menu_item)
        expect(result.error[:menu_item].errors).not_to be_empty
      end
    end
  end
end
