# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecordLimit, type: :service do
  describe "#call" do
    it "returns the integer value if limit_param is valid" do
      %w[10 30 50].each do |limit|
        expect(described_class.call(limit_param: limit)).to eq(limit.to_i)
      end
    end

    it "returns default Pagy limit if limit_param is invalid" do
      expect(described_class.call(limit_param: "99")).to eq(Pagy::OPTIONS[:limit])
      expect(described_class.call(limit_param: nil)).to eq(Pagy::OPTIONS[:limit])
    end
  end
end
