class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.all(params)
  end
end
