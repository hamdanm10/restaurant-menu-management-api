# frozen_string_literal: true

require "rails_helper"

RSpec.describe Restaurants::Create, type: :service do
  let(:valid_params) {
    {
      name: "Restaurant A",
      address: "123 Street",
      phone: "+6212341234",
      opening_hours: "Mon-Sun 08:00-22:00"

    }
  }

  let(:invalid_params) {
    {
      name: "",
      address: "",
      phone: "",
      opening_hours: ""
    }
  }

  describe "#call" do
    context "with valid params" do
      it "creates a restaurant and returns success" do
        result = described_class.call(restaurant_params: valid_params)

        expect(result).to be_success
        expect(result.payload[:restaurant]).to be_a(Restaurant)
        expect(result.payload[:restaurant].name).to eq("Restaurant A")
      end
    end

    context "with invalid params" do
      it "returns failure with the restaurant errors" do
        result = described_class.call(restaurant_params: invalid_params)

        expect(result).to be_failure
        expect(result.error[:restaurant]).to be_a(Restaurant)
        expect(result.error[:restaurant].errors).not_to be_empty
      end
    end
  end
end
