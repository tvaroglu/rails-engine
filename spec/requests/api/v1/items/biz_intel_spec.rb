require 'rails_helper'

RSpec.describe 'api/v1/revenue/items' do
  # helper methods defined in items factory:
  let!(:most_profitable_item) { item_with_revenue(6) }
  let!(:second_most_profitable_item) { item_with_revenue(4) }
  let!(:third_most_profitable_item) { item_with_revenue(2) }
  let!(:unprofitable_item) { item_without_revenue }

  describe 'happy path' do
    it 'can return up to 10 items by default, ranked by total revenue' do
      get '/api/v1/revenue/items'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 3

      data_arr.each do |record|
        expect(record.class).to eq Hash
        expect(record[:id].class).to eq String
        expect(record[:type]).to eq 'item_revenue'
        expect(record[:attributes].class).to eq Hash
        expect(record[:attributes].keys.length).to eq 5
        expect(record[:attributes][:name].class).to eq String
        expect(record[:attributes][:description].class).to eq String
        expect(record[:attributes][:unit_price].class).to eq Float
        expect(record[:attributes][:revenue].class).to eq Float
        expect(record[:attributes]).to have_key(:merchant_id)
      end
    end

    it "can return the best-selling item's revenue" do
      get '/api/v1/revenue/items?quantity=1'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 1

      record = data_arr.first

      expect(record.class).to eq Hash
      expect(record[:id].class).to eq String
      expect(record[:type]).to eq 'item_revenue'
      expect(record[:attributes].class).to eq Hash
      expect(record[:attributes].keys.length).to eq 5
      expect(record[:attributes][:name].class).to eq String
      expect(record[:attributes][:description].class).to eq String
      expect(record[:attributes][:unit_price].class).to eq Float
      expect(record[:attributes][:revenue].class).to eq Float
      expect(record[:attributes]).to have_key(:merchant_id)
    end

    it 'can return all items if a large quantity param is passed with the request' do
      get '/api/v1/revenue/items?quantity=10000000000'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 3

      data_arr.each do |record|
        expect(record.class).to eq Hash
        expect(record[:id].class).to eq String
        expect(record[:type]).to eq 'item_revenue'
        expect(record[:attributes].class).to eq Hash
        expect(record[:attributes].keys.length).to eq 5
        expect(record[:attributes][:name].class).to eq String
        expect(record[:attributes][:description].class).to eq String
        expect(record[:attributes][:unit_price].class).to eq Float
        expect(record[:attributes][:revenue].class).to eq Float
        expect(record[:attributes]).to have_key(:merchant_id)
      end
    end
  end

  describe 'edge cases' do
    it 'can return a 400 if the quantity param is an empty or negative integer within the request' do
      get '/api/v1/revenue/items?quantity=-5'
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)
      expect(json_response).to eq JsonSerializer.params_error


      get '/api/v1/revenue/items?quantity='
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)
      expect(json_response).to eq JsonSerializer.params_error
    end

    it 'can return a 400 if the quantity param is invalid within the request' do
      get '/api/v1/revenue/items?quantity=dfdsfdsfssfd'
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)
      expect(json_response).to eq JsonSerializer.params_error
    end
  end
end
