require 'rails_helper'

RSpec.describe Item do
  describe 'methods' do
    # helper methods defined in items factory:
    let!(:most_profitable_item) { item_with_revenue(6) }
    let!(:second_most_profitable_item) { item_with_revenue(4) }
    let!(:third_most_profitable_item) { item_with_revenue(2) }
    let!(:unprofitable_item) { item_without_revenue }

    it 'can return x number of items ranked by total revenue' do
      query = Item.top_x_items_by_revenue(5)

      expect(query[0].name).to eq most_profitable_item.name
      expect(query[0].revenue).to eq 21
      expect(query[1].name).to eq second_most_profitable_item.name
      expect(query[1].revenue).to eq 14
      expect(query[2].name).to eq third_most_profitable_item.name
      expect(query[2].revenue).to eq 7
    end
  end
end
