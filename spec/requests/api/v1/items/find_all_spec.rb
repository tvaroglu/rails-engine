require 'rails_helper'

RSpec.describe 'api/v1/items#find_all' do
  it 'can find all items via case insensitive search' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, name: 'A cool item', merchant_id: merchant_id)
    item_2 = create(:item, name: 'A COOLER item', merchant_id: merchant_id)
    item_3 = create(:item, name: 'A lame item', merchant_id: merchant_id)

    get "/api/v1/items/find_all?name=#{'cool'}"
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    data_arr = json_response[:data]

    expect(data_arr.class).to eq Array
    expect(data_arr.length).to eq 2

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

  it 'can return a 404 error if the item(s) not found' do
    get "/api/v1/items/find_all?name=#{'fdsfsdfdsdfdsfsdf'}"
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    data_arr = json_response[:data]

    expect(data_arr.class).to eq Array
    expect(data_arr.length).to eq 0
  end
end
