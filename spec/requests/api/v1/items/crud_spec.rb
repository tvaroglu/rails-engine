require 'rails_helper'

RSpec.describe 'api/v1/items resources::CRUD' do
  describe 'items#show' do
    it 'can find a single item' do
      merchant = create(:merchant, id: 1)
      id = create(:item, merchant_id: merchant.id).id

      get "/api/v1/items/#{id}"
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.class).to eq Hash

      data_hash = json_response[:data]

      expectations = data_hash.all? do |expectation|
        data_hash.class == Hash
        data_hash.keys.length == 3
        data_hash[:id].class == String
        data_hash[:type] == 'item'
        data_hash[:attributes].class == Hash
        data_hash[:attributes].keys.length == 4
        data_hash[:attributes][:name].class == String
        data_hash[:attributes][:description].class == String
        data_hash[:attributes][:unit_price].class == Float
        data_hash[:attributes][:merchant_id].class == Integer
      end
      expect(expectations).to be true
    end

    it 'can return a 404 error if the item is not found' do
      get "/api/v1/items/#{12345.to_s}"
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
        data_hash[:attributes][:description].class == NilClass
        data_hash[:attributes][:unit_price].class == NilClass
        data_hash[:attributes][:merchant_id].class == NilClass
      end
      expect(expectations).to be true
    end
  end

end
