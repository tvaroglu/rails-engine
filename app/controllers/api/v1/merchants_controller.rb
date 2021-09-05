class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.all(params)
  end
end
