class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    if Merchant.where(id: params[:merchant_id]).empty?
      render json: JsonSerializer.params_error, status: :not_found
    else
      render json: MerchantSerializer.items(params[:merchant_id])
    end
  end
end
