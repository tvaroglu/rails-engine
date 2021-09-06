require 'rails_helper'

RSpec.describe 'api/v1/merchants#show' do

  it 'can find a single merchant' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response.class).to eq Hash

    data_hash = json_response[:data]

    expectations = data_hash.all? do |expectation|
      data_hash.class == Hash
      data_hash.keys.length == 3
      data_hash[:id].class == String
      data_hash[:type] == 'merchant'
      data_hash[:attributes].class == Hash
      data_hash[:attributes].keys.length == 4
      data_hash[:attributes][:name].class == String
    end
    expect(expectations).to be true
  end

  it 'can return a 404 error if the merchant is not found' do
    get "/api/v1/merchants/#{12345.to_s}"
    expect(response.status).to eq 404

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response.class).to eq Hash

    data_hash = json_response[:data]

    expectations = data_hash.all? do |expectation|
      data_hash.class == Hash
      data_hash.keys.length == 3
      data_hash[:id].class == nil
      data_hash[:type] == 'item'
      data_hash[:attributes].class == Hash
      data_hash[:attributes].keys.length == 4
      data_hash[:attributes][:name].class == NilClass
    end
    expect(expectations).to be true
  end

end
