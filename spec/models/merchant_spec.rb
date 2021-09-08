require 'rails_helper'

RSpec.describe Merchant do
  describe 'methods' do
    it 'can return a single merchant based on case insensitive search and case sensitive ordering' do
      merchant_1 = create(:merchant, name: 'cool merchant')
      merchant_2 = create(:merchant, name: 'Cool merchant')

      search_results = ApplicationRecord.search(Merchant, merchant_1.name)
      expect(search_results.first.name).to eq(merchant_2.name)
    end

    # HINT: Invoices must have a successful transaction
      # AND be shipped to the customer to be considered as revenue.
    xit 'can return x number of merchants ranked by total revenue' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant_1.id)
      invoice_1 = create(:invoice, merchant_id: merchant_1.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)

      transaction_1 = create(:transaction, invoice_id: invoice_1.id)

      require "pry"; binding.pry
      # Need invoice <> transaction
        # invoice is linked to merchant!!
      # Need invoice_items <> invoice
        # links to invoice AND item tables
    end
  end
end
