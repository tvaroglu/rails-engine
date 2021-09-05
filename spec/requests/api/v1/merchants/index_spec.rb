require 'rails_helper'

RSpec.describe 'api/v1/merchants#index' do
  it 'allows for optional query params to customize formatted payload' do
    # This should fetch items 51 through 100,
      # since we’re returning 50 per “page”,
      # and we want “page 2” of data:
    create_list(:merchant, 150)

    get '/api/v1/merchants?per_page=50&page=2'
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    data_arr = json_response[:data]

    expect(data_arr.class).to eq Array
    expect(data_arr.length).to eq 50
    expect(data_arr.first[:id]).to eq '51'
    expect(data_arr.last[:id]).to eq '100'

    expectations = data_arr.all? do |expectation|
      expectation.class == Hash
      expectation[:id].class == String
      expectation[:type] == 'merchant'
      expectation[:attributes].class == Hash
      expectation[:attributes].keys.length == 1
      expectation[:attributes][:name].class == String
    end
    expect(expectations).to be true
  end

  it 'returns the first 20 merchants by default' do
    create_list(:merchant, 30)

    get '/api/v1/merchants'
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    data_arr = json_response[:data]

    expect(data_arr.class).to eq Array
    expect(data_arr.length).to eq 20

    expectations = data_arr.all? do |expectation|
      expectation.class == Hash
      expectation[:id].class == String
      expectation[:type] == 'merchant'
      expectation[:attributes].class == Hash
      expectation[:attributes].keys.length == 1
      expectation[:attributes][:name].class == String
    end
    expect(expectations).to be true
  end

  it 'returns an empty array if requested page is out of range' do
    create_list(:merchant, 30)

    get '/api/v1/merchants?page=200'

    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    data_arr = json_response[:data]

    expect(data_arr.class).to eq Array
    expect(data_arr.length).to eq 0
  end
end
