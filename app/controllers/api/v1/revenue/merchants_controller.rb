class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity].to_i <= 0 || params[:quantity].nil?
      render json: MerchantSerializer.params_error, status: :bad_request
    else
      data = Merchant.top_x_merchants_by_revenue(params[:quantity])
      render json: MerchantSerializer.top_merchants(data)
    end
  end

  def show
    if Merchant.where(id: params[:id]).empty?
      render json: MerchantSerializer.merchant_shell, status: :not_found
    else
      render json: MerchantSerializer.merchant_revenue(params[:id])
    end
  end
end
