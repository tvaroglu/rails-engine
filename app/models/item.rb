class Item < ApplicationRecord
  class << self
    def top_x_items_by_revenue(batch_size)
      select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins('INNER JOIN invoice_items ON invoice_items.item_id = items.id')
      .joins('INNER JOIN invoices ON invoice_items.invoice_id = invoices.id')
      .joins('INNER JOIN transactions ON invoices.id = transactions.invoice_id')
      .where(transactions: { result: 'success' })
      .where(invoices: { status: 'shipped' })
      .group(:id)
      .order(revenue: :desc)
      .limit(batch_size)
    end
  end
end
