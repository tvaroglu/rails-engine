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

  def find
    search_results = ApplicationRecord.search(Merchant, params[:name]) if !params[:name].nil?
    if search_results.nil? || params[:name] == ''
      render json: JsonSerializer.params_error, status: :bad_request
    elsif search_results.empty?
      render json: MerchantSerializer.merchant_shell
    else
      render json: MerchantSerializer.find(search_results.first.id)
    end
  end

  def most_items
    render json: MerchantSerializer.merchant_shell
  end
end
