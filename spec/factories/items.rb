FactoryBot.define do
  factory :item do
    name { Faker::Cannabis.strain }
    description { Faker::Cannabis.health_benefit }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    merchant_id { nil }
  end
end


def item_with_revenue(invoice_items_count = 2)
  FactoryBot.create(:item) do |item|
    FactoryBot.create(:invoice, merchant_id: item.merchant_id, status: 'shipped') do |invoice|
      FactoryBot.create(:transaction, result: 'success', invoice_id: invoice.id)
      FactoryBot.create_list(:stubbed_invoice_item, invoice_items_count, item_id: item.id, invoice_id: invoice.id)
    end
  end
end

def item_without_revenue(invoice_items_count = 2)
  FactoryBot.create(:item) do |item|
    FactoryBot.create(:invoice, merchant_id: item.merchant_id, status: 'packaged') do |invoice|
      FactoryBot.create(:transaction, result: 'success', invoice_id: invoice.id)
      FactoryBot.create_list(:stubbed_invoice_item, invoice_items_count, item_id: item.id, invoice_id: invoice.id)
    end
  end
end
