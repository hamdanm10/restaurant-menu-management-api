# frozen_string_literal: true

class Api::V1::RestaurantsController < ApplicationController
  def index
    limit = RecordLimit.call(limit_param: params[:limit])

    q = Restaurant.ransack(params[:q])
    restaurants = q.result.order(name: :asc)
    pagy, restaurants = pagy(restaurants, limit:)

    render :index, locals: { restaurants:, pagy: }, status: :ok
  end

  def show
    render :show, locals: { restaurant: restaurant_with_menu_items }, status: :ok
  end

  def create
    result = Restaurants::Create.call(restaurant_params:)

    if result.success?
      render :create, locals: { restaurant: result.payload[:restaurant] }, status: :created
    else
      raise ActiveRecord::RecordInvalid.new(result.error[:restaurant])
    end
  end

  def update
    result = Restaurants::Update.call(
      restaurant:,
      restaurant_params:
    )

    if result.success?
      render :update, locals: { restaurant: result.payload[:restaurant] }, status: :ok
    else
      raise ActiveRecord::RecordInvalid.new(result.error[:restaurant])
    end
  end

  def destroy
    Restaurants::Destroy.call(restaurant:)

    render :destroy, status: :ok
  end

  private

  def restaurant
    Restaurant.find(params[:id])
  end

  def restaurant_with_menu_items
    Restaurant.includes(:menu_items).find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(
      :name,
      :address,
      :phone,
      :opening_hours
    )
  end
end
