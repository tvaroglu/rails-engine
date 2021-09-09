require 'rails_helper'

RSpec.describe 'api/v1/revenue/merchants' do
  # helper methods defined in merchants factory:
  let!(:most_profitable_merchant) { merchant_with_revenue(6) }
  let!(:second_most_profitable_merchant) { merchant_with_revenue(4) }
  let!(:third_most_profitable_merchant) { merchant_with_revenue(2) }
  let!(:unprofitable_merchant) { merchant_without_revenue }

  describe 'happy path' do
    it 'can return x number of merchants ranked by total revenue' do
      get '/api/v1/revenue/merchants?quantity=5'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 3

      data_arr.each do |record|
        expect(record.class).to eq Hash
        expect(record[:id].class).to eq String
        expect(record[:type]).to eq 'merchant_name_revenue'
        expect(record[:attributes].class).to eq Hash
        expect(record[:attributes].keys.length).to eq 2
        expect(record[:attributes][:name].class).to eq String
        expect(record[:attributes][:revenue].class).to eq Float
      end
    end

    it "can return a single merchant's revenue" do
      get "/api/v1/revenue/merchants/#{most_profitable_merchant.id}"
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.class).to eq Hash

      data_hash = json_response[:data]

      expect(data_hash.class).to eq Hash
      expect(data_hash.keys.length).to eq 3
      expect(data_hash[:id].class).to eq String
      expect(data_hash[:type]).to eq 'merchant_revenue'
      expect(data_hash[:attributes].class).to eq Hash
      expect(data_hash[:attributes].keys.length).to eq 1
      expect(data_hash[:attributes][:revenue].class).to eq Float
    end

    it 'can return x number of merchants ranked by total items sold' do
      get '/api/v1/merchants/most_items?quantity=5'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 3

      data_arr.each do |record|
        expect(record.class).to eq Hash
        expect(record[:id].class).to eq String
        expect(record[:type]).to eq 'merchant'
        expect(record[:attributes].class).to eq Hash
        expect(record[:attributes].keys.length).to eq 2
        expect(record[:attributes][:name].class).to eq String
        expect(record[:attributes][:count].class).to eq Integer
      end
    end
  end

  describe 'edge cases' do
    it 'can return a 400 if the quantity param is empty within the request' do
      get '/api/v1/revenue/merchants?quantity='
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)
      expect(json_response).to eq JsonSerializer.params_error


      get '/api/v1/merchants/most_items?quantity='
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)
      expect(json_response).to eq JsonSerializer.params_error
    end

    it 'can return a 400 if the quantity param is invalid within the request' do
      get '/api/v1/revenue/merchants?quantity=dsfdsfsdfsdfdsfs'
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)
      expect(json_response).to eq JsonSerializer.params_error


      get '/api/v1/merchants/most_items?quantity=dsfdsfsdfsdfdsfs'
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)
      expect(json_response).to eq JsonSerializer.params_error
    end

    it 'can return a 400 if the quantity param is missing within the request' do
      get '/api/v1/revenue/merchants'
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)
      expect(json_response).to eq JsonSerializer.params_error


      get '/api/v1/merchants/most_items'
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)
      expect(json_response).to eq JsonSerializer.params_error
    end

    it "can return a 404 if the merchant id isn't found" do
      get '/api/v1/revenue/merchants/dfdsfdsfssfd'
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
end
