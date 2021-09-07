require 'rails_helper'

RSpec.describe 'api/v1/items/:id/merchant#index' do
  it 'returns the merchant data associated with the item' do
    merchant_id = create(:merchant).id
    id = create(:item, merchant_id: merchant_id).id

    get "/api/v1/items/#{id}/merchant"
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

  it 'returns a 404 if the item is not found' do
    get "/api/v1/items/#{12345}/merchant"
    expect(response.status).to eq 404

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response.class).to eq Hash

    data_hash = json_response[:data]

    expect(data_hash.class).to eq Hash
    expect(data_hash.keys.length).to eq 3
    expect(data_hash[:id].class).to eq NilClass
    expect(data_hash[:type]).to eq 'item'
    expect(data_hash[:attributes].class).to eq Hash
    expect(data_hash[:attributes].keys.length).to eq 4
    expect(data_hash[:attributes][:name].class).to eq NilClass
    expect(data_hash[:attributes][:description].class).to eq NilClass
    expect(data_hash[:attributes][:unit_price].class).to eq NilClass
    expect(data_hash[:attributes][:merchant_id].class).to eq NilClass
  end
end
