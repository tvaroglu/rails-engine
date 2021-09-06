class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.all(params)
  end

  def show
    if Item.where(id: params[:id]).empty?
      render json: ItemSerializer.item_shell, status: :not_found
    else
      render json: ItemSerializer.find(params[:id])
    end
  end

  def create
    render json: Item.create(item_params), status: :created
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
