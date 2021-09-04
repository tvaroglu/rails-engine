require 'rails_helper'

describe 'api/v1/merchants#index' do
  it 'sends an array of 20 merchants by default' do
    create_list(:merchant, 60)

    get '/api/v1/merchants'
    # get '/api/v1/merchants?per_page=30&page=2'
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    # require "pry"; binding.pry
    expect(json_response[:data].count).to eq(20)
  end

  xit 'allows for optional query params to customize payload' do
    # This should fetch items 51 through 100,
      # since we’re returning 50 per “page”,
      # and we want “page 2” of data:
    # GET /api/v1/items?per_page=50&page=2
    # GET /api/v1/merchants?per_page=50&page=2
  end
end
