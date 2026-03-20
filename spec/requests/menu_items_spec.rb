# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::MenuItems", type: :request do
  def json
    JSON.parse(response.body)
  end

  describe "GET /api/v1/restaurants/:id/menu_items" do
    let!(:restaurant) { create(:restaurant) }
    let!(:menu_item_a) { create(:menu_item, name: "Menu Item A", category: :main, restaurant:) }
    let!(:menu_item_b) { create(:menu_item, name: "Menu Item B", category: :main, restaurant:) }
    let!(:menu_item_v) { create(:menu_item, name: "Menu Item C", category: :appetizer, restaurant:) }

    it "returns 200 and success status" do
      get api_v1_restaurant_menu_items_path(restaurant), as: :json

      expect(response).to have_http_status(:ok)
      expect(json["status"]).to eq("success")
    end

    it "returns sorted menu items" do
      get api_v1_restaurant_menu_items_path(restaurant), as: :json

      actual_menu_list = json["data"]["menu_items"].map do |menu_item|
        [ menu_item["name"], menu_item["category"] ]
      end

      expected_menu_list = [
        [ "Menu Item C", "appetizer" ],
        [ "Menu Item A", "main" ],
        [ "Menu Item B", "main" ]
      ]

      expect(actual_menu_list).to eq(expected_menu_list)
    end

    it "supports filtering by category (ransack)" do
      query_params = { q: { category_eq: :main } }.to_query
      get "#{api_v1_restaurant_menu_items_path(restaurant)}?#{query_params}", as: :json

      menu_items_categories = json["data"]["menu_items"].map { |menu_item| menu_item["category"] }

      expect(menu_items_categories).to all(eq("main"))
      expect(menu_items_categories).not_to include("appetizer")
      expect(json["data"]["menu_items"].size).to eq(2)
    end

    it "supports pagination (limit)" do
      create_list(:menu_item, 10, restaurant:)

      query_params = { q: { limit: "10" } }.to_query
      get "#{api_v1_restaurant_menu_items_path(restaurant)}?#{query_params}", as: :json

      expect(json["data"]["menu_items"].size).to eq(10)
      expect(json["pagination"]).to be_present
    end
  end

  describe "POST /api/v1/restaurants/:id/menu_items" do
    let!(:restaurant) { create(:restaurant) }

    let(:params) do
      {
        menu_item: {
          retaurant_id: restaurant.id,
          name: "New Menu Item",
          description: "New Description",
          price: 10,
          category: :main,
          is_available: true
        }
      }
    end

    it "creates menu item" do
      expect {
        post api_v1_restaurant_menu_items_path(restaurant), params:, as: :json
      }.to change(MenuItem, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json["data"]["menu_item"]["name"]).to eq("New Menu Item")
    end
  end

  describe "PUT /api/v1/menu_items/:id" do
    let!(:menu_item) { create(:menu_item, name: "Old Name") }

    it "updates menu item" do
      put api_v1_menu_item_path(menu_item),
            params: { menu_item: { name: "Updated Name" } },
            as: :json

      expect(response).to have_http_status(:ok)
      expect(menu_item.reload.name).to eq("Updated Name")
    end
  end

  describe "DELETE /api/v1/menu_items/:id" do
    let!(:menu_item) { create(:menu_item) }

    it "deletes menu item" do
      expect {
        delete api_v1_menu_item_path(menu_item), as: :json
      }.to change(MenuItem, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(json["data"]).to be_nil
    end
  end
end
