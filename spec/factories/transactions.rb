FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Date.forward(days: 365) }
    result { %w[failed success refunded].sample }
    invoice_id { nil }
  end
end
