# frozen_string_literal: true

class Api::V1::MenuItemsController < ApplicationController
  def index
    limit = RecordLimit.call(limit_param: params[:limit])

    q = restaurant.menu_items.ransack(params[:q])
    menu_items = q.result.order(category: :asc, name: :asc)
    pagy, menu_items = pagy(menu_items, limit:)

    render :index, locals: { menu_items:, pagy: }, status: :ok
  end

  def create
    result = MenuItems::Create.call(
      restaurant:,
      menu_item_params:
    )

    if result.success?
      render :create, locals: { menu_item: result.payload[:menu_item] }, status: :created
    else
      raise ActiveRecord::RecordInvalid.new(result.error[:menu_item])
    end
  end

  def update
    result = MenuItems::Update.call(
      menu_item:,
      menu_item_params:
    )

    if result.success?
      render :update, locals: { menu_item: result.payload[:menu_item] }, status: :ok
    else
      raise ActiveRecord::RecordInvalid.new(result.error[:menu_item])
    end
  end

  def destroy
    MenuItems::Destroy.call(menu_item:)

    render :destroy, status: :ok
  end

  private

  def restaurant
    Restaurant.find(params[:restaurant_id])
  end

  def menu_item
    MenuItem.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(
      :name,
      :description,
      :price,
      :category,
      :is_available
    )
  end
end
