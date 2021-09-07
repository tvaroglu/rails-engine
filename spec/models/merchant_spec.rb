require 'rails_helper'

RSpec.describe Merchant do
  describe 'methods' do
    it 'can return a single merchant based on case insensitive search and case sensitive ordering' do
      merchant_1 = create(:merchant, name: 'cool merchant')
      merchant_2 = create(:merchant, name: 'Cool merchant')

      search_results = ApplicationRecord.search(Merchant, merchant_1.name)
      expect(search_results.first.name).to eq(merchant_2.name)
    end
  end
end
