class Merchant < ApplicationRecord
  def self.top_x_merchants_by_revenue(number_of_merchants)
    select('merchants.id, merchants.name AS name,
      SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins('INNER JOIN invoices ON invoices.merchant_id = merchants.id')
      .joins('INNER JOIN transactions ON invoices.id = transactions.invoice_id')
      .joins('INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id')
      .where(transactions: { result: 'success' })
      .where(invoices: { status: 'shipped' })
      .group(:id)
      .order(revenue: :desc)
      .limit(number_of_merchants)
  end
end
