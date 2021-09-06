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
    begin
      new_item = Item.create(item_params)
    rescue ActionController::ParameterMissing
      render json: ItemSerializer.params_error, status: :bad_request
    end
    render json: ItemSerializer.create_record(new_item), status: :created if new_item
  end

  def update
    if !params[:merchant_id].nil?
      bad_merchant_id = true if Merchant.where(id: params[:merchant_id]).empty?
    end
    if Item.where(id: params[:id]).empty? || params[:id].to_i == 0 || bad_merchant_id
      render json: ItemSerializer.item_shell, status: :not_found
    else
      render json: ItemSerializer.update_record(params, item_params), status: :accepted
    end
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
