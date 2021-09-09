require 'rails_helper'

RSpec.describe 'api/v1/merchants/:id/items#index' do
  it 'returns all items associated with the merchant' do
    id = create(:merchant).id
    10.times { create(:item, merchant_id: id) }
    10.times { create(:item) }

    get "/api/v1/merchants/#{id}/items"
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    data_arr = json_response[:data]

    expect(data_arr.class).to eq Array
    expect(data_arr.length).to eq 10

    data_arr.each do |record|
      expect(record.class).to eq Hash
      expect(record[:id].class).to eq String
      expect(record[:type]).to eq 'item'
      expect(record[:attributes].class).to eq Hash
      expect(record[:attributes].keys.length).to eq 4
      expect(record[:attributes][:name].class).to eq String
      expect(record[:attributes][:description].class).to eq String
      expect(record[:attributes][:unit_price].class).to eq Float
      expect(record[:attributes][:merchant_id]).to eq id
    end
  end

  it 'returns a 404 if the merchant is not found' do
    get "/api/v1/merchants/#{12345}/items"
    expect(response.status).to eq 404

    json_response = JSON.parse(response.body)

    expect(json_response).to eq JsonSerializer.params_error
  end
end
