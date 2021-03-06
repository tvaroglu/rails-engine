require 'rails_helper'

RSpec.describe 'api/v1/merchants#index' do
  describe 'happy path' do
    it 'returns the first 20 merchants by default' do
      create_list(:merchant, 30)

      get '/api/v1/merchants'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 20

      data_arr.each do |record|
        expect(record.class).to eq Hash
        expect(record[:id].class).to eq String
        expect(record[:type]).to eq 'merchant'
        expect(record[:attributes].class).to eq Hash
        expect(record[:attributes].keys.length).to eq 1
        expect(record[:attributes][:name].class).to eq String
      end
    end

    it 'allows for optional query params to customize formatted payload' do
      # This should fetch items 51 through 100,
        # since we’re returning 50 per “page”,
        # and we want “page 2” of data:
      create_list(:merchant, 50)
      create(:merchant, name: 'Merchant#51')
      create_list(:merchant, 48)
      create(:merchant, name: 'Merchant#100')
      create_list(:merchant, 50)

      get '/api/v1/merchants?per_page=50&page=2'
      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 50
      expect(data_arr.first[:attributes][:name]).to eq 'Merchant#51'
      expect(data_arr.last[:attributes][:name]).to eq 'Merchant#100'

      data_arr.each do |record|
        expect(record.class).to eq Hash
        expect(record[:id].class).to eq String
        expect(record[:type]).to eq 'merchant'
        expect(record[:attributes].class).to eq Hash
        expect(record[:attributes].keys.length).to eq 1
        expect(record[:attributes][:name].class).to eq String
      end
    end
  end

  describe 'edge cases' do
    it 'returns an empty array if requested page is out of range' do
      create_list(:merchant, 30)

      get '/api/v1/merchants?page=200'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 0
    end

    it 'returns the entire table if the batch size exceeds table length' do
      create_list(:merchant, 30)

      get '/api/v1/merchants?per_page=200'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      data_arr = json_response[:data]

      expect(data_arr.class).to eq Array
      expect(data_arr.length).to eq 30
    end
  end
end
