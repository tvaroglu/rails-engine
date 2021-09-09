require 'rails_helper'

RSpec.describe Merchant do
  describe 'methods' do
    # helper methods defined in merchants factory:
    let!(:most_profitable_merchant) { merchant_with_revenue(6) }
    let!(:second_most_profitable_merchant) { merchant_with_revenue(4) }
    let!(:third_most_profitable_merchant) { merchant_with_revenue(2) }
    let!(:unprofitable_merchant) { merchant_without_revenue }

    it 'can return a single merchant based on case insensitive search and case sensitive ordering' do
      merchant_1 = create(:merchant, name: 'cool merchant')
      merchant_2 = create(:merchant, name: 'Cool merchant')

      search_results = ApplicationRecord.search(Merchant, merchant_1.name)
      expect(search_results.first.name).to eq(merchant_2.name)
    end

    it 'can return x number of merchants ranked by total revenue' do
      query = Merchant.top_x_merchants_by_revenue(5)

      expect(query[0].name).to eq most_profitable_merchant.name
      expect(query[0].revenue).to eq 21
      expect(query[1].name).to eq second_most_profitable_merchant.name
      expect(query[1].revenue).to eq 14
      expect(query[2].name).to eq third_most_profitable_merchant.name
      expect(query[2].revenue).to eq 7

      expect(Merchant.revenue_for_merchant(most_profitable_merchant.id).first.revenue).to eq 21
    end

    it 'can return x number of merchants ranked by items sold' do
      query = Merchant.top_x_merchants_by_items_sold(5)

      expect(query[0].name).to eq most_profitable_merchant.name
      expect(query[0]._count).to eq 6
      expect(query[1].name).to eq second_most_profitable_merchant.name
      expect(query[1]._count).to eq 4
      expect(query[2].name).to eq third_most_profitable_merchant.name
      expect(query[2]._count).to eq 2
    end
  end
end
