# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Restaurants", type: :request do
  def json
    JSON.parse(response.body)
  end

  describe "GET /api/v1/restaurants" do
    let!(:restaurant_a) { create(:restaurant, name: "Restaurant A") }
    let!(:restaurant_b) { create(:restaurant, name: "Restaurant B") }

    it "returns 200 and success status" do
      get api_v1_restaurants_path, as: :json

      expect(response).to have_http_status(:ok)
      expect(json["status"]).to eq("success")
    end

    it "returns sorted restaurants" do
      get api_v1_restaurants_path, as: :json

      names = json["data"]["restaurants"].map { |restaurant| restaurant["name"] }

      expect(names).to eq(names.sort)
    end

    it "supports filtering (ransack)" do
      query_params = { q: { name_cont: "Restaurant A" } }.to_query
      get "#{api_v1_restaurants_path}?#{query_params}", as: :json

      names = json["data"]["restaurants"].map { |restaurant| restaurant["name"] }

      expect(names).to all(include("A"))
    end

    it "supports pagination (limit)" do
      create_list(:restaurant, 10)

      query_params = { q: { limit: "10" } }.to_query
      get "#{api_v1_restaurants_path}?#{query_params}", as: :json

      expect(json["data"]["restaurants"].size).to eq(10)
      expect(json["pagination"]).to be_present
    end
  end

  describe "GET /api/v1/restaurants/:id" do
    let!(:restaurant) { create(:restaurant) }

    it "returns restaurant detail with menu items" do
      create(:menu_item, restaurant:)

      get api_v1_restaurant_path(restaurant), as: :json

      expect(response).to have_http_status(:ok)
      expect(json["data"]["restaurant"]["id"]).to eq(restaurant.id)
      expect(json["data"]["restaurant"]["menu_items"]).to be_present
    end
  end

  describe "POST /api/v1/restaurants" do
    let(:params) do
      {
        restaurant: {
          name: "New Restaurant",
          address: "New Address",
          phone: "+6212345678",
          opening_hours: "Mon-Sun 08:00-22:00"
        }
      }
    end

    it "creates restaurant" do
      expect {
        post api_v1_restaurants_path, params:, as: :json
      }.to change(Restaurant, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json["data"]["restaurant"]["name"]).to eq("New Restaurant")
    end
  end

  describe "PUT /api/v1/restaurants/:id" do
    let!(:restaurant) { create(:restaurant, name: "Old Name") }

    it "updates restaurant" do
      put api_v1_restaurant_path(restaurant),
            params: { restaurant: { name: "Updated Name" } },
            as: :json

      expect(response).to have_http_status(:ok)
      expect(restaurant.reload.name).to eq("Updated Name")
    end
  end

  describe "DELETE /api/v1/restaurants/:id" do
    let!(:restaurant) { create(:restaurant) }

    it "deletes restaurant" do
      expect {
        delete api_v1_restaurant_path(restaurant), as: :json
      }.to change(Restaurant, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(json["data"]).to be_nil
    end
  end
end
