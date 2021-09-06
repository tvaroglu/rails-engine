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
end
