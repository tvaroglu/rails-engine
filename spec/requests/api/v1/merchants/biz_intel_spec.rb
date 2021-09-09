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
  end

  describe 'edge cases' do
    it 'can return a 400 if the quantity param is empty within the request' do
      get '/api/v1/revenue/merchants?quantity='
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)

      expect(json_response).to eq JsonSerializer.params_error
    end

    it 'can return a 400 if the quantity param is invalid in the request' do
      get '/api/v1/revenue/merchants?quantity=dsfdsfsdfsdfdsfs'
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)

      expect(json_response).to eq JsonSerializer.params_error
    end

    it 'can return a 400 if the quantity param is missing from the request' do
      get '/api/v1/revenue/merchants?quantity'
      expect(response.status).to eq 400

      json_response = JSON.parse(response.body)

      expect(json_response).to eq JsonSerializer.params_error
    end
  end
end
