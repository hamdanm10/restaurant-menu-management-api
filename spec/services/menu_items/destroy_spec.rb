# frozen_string_literal: true

require "rails_helper"

RSpec.describe MenuItems::Destroy, type: :service do
  let(:menu_item) { create(:menu_item) }

  describe "#call" do
    it "destroys the menu_item and returns success" do
      result = described_class.call(menu_item: menu_item)

      expect(result).to be_success
      expect(MenuItem.exists?(menu_item.id)).to be_falsey
    end
  end
end
