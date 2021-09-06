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

  describe 'items#create and items#destroy' do
    it 'can create and delete a new item if valid attributes are provided' do
      id = create(:merchant, id: 1).id
      item_params = {
        name: 'Item1',
        description: 'A really cool item',
        unit_price: 49.99,
        merchant_id: id
      }

      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

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

      delete "/api/v1/items/#{created_item.id}"
      expect(response).to be_successful
      expect{Item.find(created_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns an error if empty params are provided' do
      item_params = {}
      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      expect(response.status).to eq 400

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.class).to eq Hash
      expect(json_response[:error]).to eq 'bad or missing attributes'
    end
  end

end
