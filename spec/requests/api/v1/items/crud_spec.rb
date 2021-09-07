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

      expect(data_hash.class).to eq Hash
      expect(data_hash.keys.length).to eq 3
      expect(data_hash[:id].class).to eq String
      expect(data_hash[:type]).to eq 'item'
      expect(data_hash[:attributes].class).to eq Hash
      expect(data_hash[:attributes].keys.length).to eq 4
      expect(data_hash[:attributes][:name].class).to eq String
      expect(data_hash[:attributes][:description].class).to eq String
      expect(data_hash[:attributes][:unit_price].class).to eq Float
      expect(data_hash[:attributes][:merchant_id].class).to eq Integer
    end

    it 'can return a 404 error if the item is not found' do
      get "/api/v1/items/#{12345.to_s}"
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

      expect(data_hash.class).to eq Hash
      expect(data_hash.keys.length).to eq 3
      expect(data_hash[:id].class).to eq String
      expect(data_hash[:type]).to eq 'item'
      expect(data_hash[:attributes].class).to eq Hash
      expect(data_hash[:attributes].keys.length).to eq 4
      expect(data_hash[:attributes][:name].class).to eq String
      expect(data_hash[:attributes][:description].class).to eq String
      expect(data_hash[:attributes][:unit_price].class).to eq Float
      expect(data_hash[:attributes][:merchant_id].class).to eq Integer

      delete "/api/v1/items/#{created_item.id}"

      expect(response.status).to eq 204
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

  describe 'items#update: happy path' do
    it 'can update an item with all params' do
      merchant = create(:merchant, id: 1)
      id = create(:item, merchant_id: merchant.id).id

      previous_name = Item.last.name
      previous_description = Item.last.description
      previous_unit_price = Item.last.unit_price

      item_params = {
        name: 'A new name',
        description: 'A new description',
        unit_price: 12.34,
        merchant_id: merchant.id
      }

      headers = {'CONTENT_TYPE' => 'application/json'}
      put "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

      item = Item.find_by(id: id)
      expect(response).to be_successful

      expect(item.name).to_not eq(previous_name)
      expect(item.description).to_not eq(previous_description)
      expect(item.unit_price).to_not eq(previous_unit_price)
      expect(item.name).to eq('A new name')
      expect(item.description).to eq('A new description')
      expect(item.unit_price).to eq(12.34)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.class).to eq Hash

      data_hash = json_response[:data]

      expect(data_hash.class).to eq Hash
      expect(data_hash.keys.length).to eq 3
      expect(data_hash[:id].class).to eq String
      expect(data_hash[:type]).to eq 'item'
      expect(data_hash[:attributes].class).to eq Hash
      expect(data_hash[:attributes].keys.length).to eq 4
      expect(data_hash[:attributes][:name].class).to eq String
      expect(data_hash[:attributes][:description].class).to eq String
      expect(data_hash[:attributes][:unit_price].class).to eq Float
      expect(data_hash[:attributes][:merchant_id].class).to eq Integer
    end

    it 'can update an item with partial params' do
      merchant = create(:merchant, id: 1)
      id = create(:item, merchant_id: merchant.id).id

      previous_name = Item.last.name
      item_params = { name: 'A new name' }

      headers = {'CONTENT_TYPE' => 'application/json'}
      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq('A new name')

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.class).to eq Hash

      data_hash = json_response[:data]

      expect(data_hash.class).to eq Hash
      expect(data_hash.keys.length).to eq 3
      expect(data_hash[:id].class).to eq String
      expect(data_hash[:type]).to eq 'item'
      expect(data_hash[:attributes].class).to eq Hash
      expect(data_hash[:attributes].keys.length).to eq 4
      expect(data_hash[:attributes][:name].class).to eq String
      expect(data_hash[:attributes][:description].class).to eq String
      expect(data_hash[:attributes][:unit_price].class).to eq Float
      expect(data_hash[:attributes][:merchant_id].class).to eq Integer
    end
  end

  describe 'items#update: sad path' do
    it "can't update an item with an unfound item id" do
      merchant = create(:merchant, id: 1)
      id = create(:item, merchant_id: merchant.id).id

      item_params = {
        name: 'A new name',
        description: 'A new description',
        unit_price: 12.34,
        merchant_id: merchant.id
      }

      headers = {'CONTENT_TYPE' => 'application/json'}
      put "/api/v1/items/#{12345}", headers: headers, params: JSON.generate({item: item_params})

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

    it "can't update an item with an unfound merchant_id" do
      id = create(:item).id

      item_params = {
        name: 'A new name',
        description: 'A new description',
        unit_price: 12.34
      }

      headers = {'CONTENT_TYPE' => 'application/json'}
      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params, merchant_id: nil})

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

end
