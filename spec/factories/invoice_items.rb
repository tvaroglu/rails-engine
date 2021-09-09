FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.number(digits: 2) }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    invoice_id { nil }
    item_id { nil }
  end

  factory :stubbed_invoice_item, parent: :invoice_item do
    quantity { 1 }
    unit_price { 3.50 }
  end
end
