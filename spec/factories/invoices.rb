FactoryBot.define do
  factory :invoice do
    status { %w[shipped packaged returned].sample }
    customer_id { nil }
    merchant_id { nil }
  end
end


def invoice_with_revenue(invoice_items_count = 2, status: 'shipped', result: 'success')
  FactoryBot.create(:invoice, status: status) do |invoice|
    FactoryBot.create(:item) do |item|
      FactoryBot.create(:transaction, result: result, invoice_id: invoice.id)
      FactoryBot.create_list(:stubbed_invoice_item, invoice_items_count, item_id: item.id, invoice_id: invoice.id)
    end
  end
end

def invoice_without_revenue(invoice_items_count = 2, status: 'shipped', result: 'failed')
  FactoryBot.create(:invoice, status: status) do |invoice|
    FactoryBot.create(:item) do |item|
      FactoryBot.create(:transaction, result: result, invoice_id: invoice.id)
      FactoryBot.create_list(:stubbed_invoice_item, invoice_items_count, item_id: item.id, invoice_id: invoice.id)
    end
  end
end
