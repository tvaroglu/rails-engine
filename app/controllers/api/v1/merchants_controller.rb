class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.all(params)
  end

  def show
    if Merchant.where(id: params[:id]).empty?
      render json: MerchantSerializer.merchant_shell, status: :not_found
    else
      render json: MerchantSerializer.find(params[:id])
    end
  end
end
