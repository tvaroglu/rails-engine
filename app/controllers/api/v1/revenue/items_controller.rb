class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    render json: JsonSerializer.params_error
  end
end
