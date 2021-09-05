require 'rails_helper'

RSpec.describe 'api/v1/items resources::CRUD' do
  describe 'items#show' do
    it 'finds a single item' do
      id = create(:item).id

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
        data_hash[:attributes].keys.length == 3
        data_hash[:attributes][:name].class == String
        data_hash[:attributes][:description].class == String
        data_hash[:attributes][:unit_price].class == Float
      end
      expect(expectations).to be true
    end

    xit 'returns a 404 error if record not found' do
      get "/api/v1/items/#{12345}"
      # expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      require "pry"; binding.pry
    end
  end

end
