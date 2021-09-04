class MerchantSerializer

  def self.all(query_params)
    # require "pry"; binding.pry
    query_params[:per_page].nil? ? per_page = 20 : per_page = query_params[:per_page]
    Merchant.all.limit(per_page)
  end

end
