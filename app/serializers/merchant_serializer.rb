class MerchantSerializer < JsonSerializer
  def self.all(query_params)
    render_all(query_params, Merchant)
  end
end
