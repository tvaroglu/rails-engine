require 'rails_helper'

RSpec.describe 'api/v1/items#index' do
  describe 'happy path' do
    it 'allows for optional query params to customize formatted payload' do
      # This should fetch items 51 through 100,
        # since we’re returning 50 per “page”,
        # and we want “page 2” of data:
      create_list(:item, 150)

      get '/api/v1/items?per_page=50&page=2'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 50
      expect(data_arr.first[:id]).to eq '51'
      expect(data_arr.last[:id]).to eq '100'

      data_arr.each do |record|
        expect(record.class).to eq Hash
        expect(record[:id].class).to eq String
        expect(record[:type]).to eq 'item'
        expect(record[:attributes].class).to eq Hash
        expect(record[:attributes].keys.length).to eq 4
        expect(record[:attributes][:name].class).to eq String
        expect(record[:attributes][:description].class).to eq String
        expect(record[:attributes][:unit_price].class).to eq Float
      end
    end

    it 'returns the first 20 items by default' do
      create_list(:item, 30)

      get '/api/v1/items'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 20

      data_arr.each do |record|
        expect(record.class).to eq Hash
        expect(record[:id].class).to eq String
        expect(record[:type]).to eq 'item'
        expect(record[:attributes].class).to eq Hash
        expect(record[:attributes].keys.length).to eq 4
        expect(record[:attributes][:name].class).to eq String
        expect(record[:attributes][:description].class).to eq String
        expect(record[:attributes][:unit_price].class).to eq Float
      end
    end
  end

  describe 'edge cases' do
    it 'returns an empty array if requested page is out of range' do
      create_list(:item, 30)

      get '/api/v1/items?page=200'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 0
    end

    it 'returns the entire table if the batch size exceeds table length' do
      create_list(:item, 30)

      get '/api/v1/items?per_page=200'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 30
    end
  end
end
