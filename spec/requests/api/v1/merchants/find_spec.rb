require 'rails_helper'

RSpec.describe 'api/v1/merchants#find' do
  it 'can find a single merchant via case sensitive search' do
    merchant_1 = create(:merchant, name: 'Cool merchant')
    merchant_2 = create(:merchant, name: 'cool merchant')

    get "/api/v1/merchants/find?name=#{merchant_1.name}"
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response.class).to eq Hash

    data_hash = json_response[:data]

    expect(data_hash.class).to eq Hash
    expect(data_hash.keys.length).to eq 3
    expect(data_hash[:id].class).to eq String
    expect(data_hash[:type]).to eq 'merchant'
    expect(data_hash[:attributes].class).to eq Hash
    expect(data_hash[:attributes].keys.length).to eq 1
    expect(data_hash[:attributes][:name].class).to eq String
  end

  it 'can return a 404 error if the merchant is not found' do
    get "/api/v1/merchants/find?name=#{'fdsfsdfdsdfdsfsdf'}"
    expect(response.status).to eq 404

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response.class).to eq Hash

    data_hash = json_response[:data]

    expect(data_hash.class).to eq Hash
    expect(data_hash.keys.length).to eq 3
    expect(data_hash[:id].class).to eq NilClass
    expect(data_hash[:type]).to eq 'merchant'
    expect(data_hash[:attributes].class).to eq Hash
    expect(data_hash[:attributes].keys.length).to eq 1
    expect(data_hash[:attributes][:name].class).to eq NilClass
  end
end
