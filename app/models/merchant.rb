class Merchant < ApplicationRecord
  class << self
    def top_x_merchants_by_revenue(batch_size)
      select('merchants.id, merchants.name,
        SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
        .joins('INNER JOIN invoices ON invoices.merchant_id = merchants.id')
        .joins('INNER JOIN transactions ON invoices.id = transactions.invoice_id')
        .joins('INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id')
        .where(transactions: { result: 'success' })
        .where(invoices: { status: 'shipped' })
        .group(:id)
        .order(revenue: :desc)
        .limit(batch_size)
    end

    def revenue_for_merchant(merchant_id)
      top_x_merchants_by_revenue(Merchant.all.length)
      .where(id: merchant_id)
    end

    def top_x_merchants_by_items_sold(batch_size = 5)
      select('merchants.id, merchants.name, SUM(invoice_items.quantity) AS _count')
      .joins('INNER JOIN invoices ON invoices.merchant_id = merchants.id')
      .joins('INNER JOIN transactions ON invoices.id = transactions.invoice_id')
      .joins('INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id')
      .where(transactions: { result: 'success' })
      .where(invoices: { status: 'shipped' })
      .group(:id)
      .order(_count: :desc)
      .limit(batch_size)
    end
  end
end
