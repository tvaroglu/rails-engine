class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.params_error
  end
end
