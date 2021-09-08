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
      render json: JsonSerializer.params_error, status: :bad_request
    end
    render json: ItemSerializer.find(new_item.id), status: :created if new_item
  end

  def update
    if !params.keys.index('merchant_id').nil?
      bad_merchant_id = true if Merchant.where(id: params[:merchant_id]).empty?
    end
    if Item.where(id: params[:id]).empty? || params[:id].to_i.zero? || bad_merchant_id
      render json: ItemSerializer.item_shell, status: :not_found
    else
      render json: ItemSerializer.update(params, item_params), status: :accepted
    end
  end

  def destroy
    render json: Item.delete(params[:id]), status: :no_content
  end

  def find_all
    search_results = ApplicationRecord.search(Item, params[:name]) if !params[:name].nil?
    if search_results.nil? || params[:name] == ''
      render json: JsonSerializer.params_error, status: :bad_request
    elsif search_results.empty?
      render json: ItemSerializer.output_hash([])
    else
      render json: ItemSerializer.output_hash(search_results)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
