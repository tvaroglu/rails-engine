class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    render json: JsonSerializer.params_error
  end

  def show
    render json: MerchantSerializer.merchant_shell
  end
end
