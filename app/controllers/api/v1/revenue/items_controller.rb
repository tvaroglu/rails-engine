class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    if !params[:quantity].nil? && params[:quantity].to_i <= 0
      render json: ItemSerializer.params_error, status: :bad_request
    else
      params[:quantity].nil? ? batch_size = 10 : batch_size = params[:quantity]
      data = Item.top_x_items_by_revenue(batch_size)
      render json: ItemSerializer.top_items_by_revenue(data)
    end
  end
end
