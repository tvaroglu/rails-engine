FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  end
end


def merchant_with_revenue(invoice_items_count = 2)
  FactoryBot.create(:merchant) do |merchant|
    FactoryBot.create(:item, merchant_id: merchant.id) do |item|
      FactoryBot.create(:invoice, merchant_id: merchant.id, status: 'shipped') do |invoice|
        FactoryBot.create(:transaction, result: 'success', invoice_id: invoice.id)
        FactoryBot.create_list(:stubbed_invoice_item, invoice_items_count, item_id: item.id, invoice_id: invoice.id)
      end
    end
  end
end

def merchant_without_revenue(invoice_items_count = 2)
  FactoryBot.create(:merchant) do |merchant|
    FactoryBot.create(:item, merchant_id: merchant.id) do |item|
      FactoryBot.create(:invoice, merchant_id: merchant.id, status: 'packaged') do |invoice|
        FactoryBot.create(:transaction, result: 'success', invoice_id: invoice.id)
        FactoryBot.create_list(:stubbed_invoice_item, invoice_items_count, item_id: item.id, invoice_id: invoice.id)
      end
    end
  end
end
