class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.all(params)
  end

  def show
    render json: ItemSerializer.find(params[:id])
  end
end
