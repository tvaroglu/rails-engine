class Api::V1::Items::MerchantController < ApplicationController
  def index
    if Item.where(id: params[:item_id]).empty?
      render json: ItemSerializer.item_shell, status: :not_found
    else
      render json: ItemSerializer.merchant(params[:item_id])
    end
  end
end
