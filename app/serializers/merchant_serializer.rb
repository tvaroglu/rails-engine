class MerchantSerializer

  def self.all(query_params)
    query_params[:per_page].nil? ? per_page = 20 : per_page = query_params[:per_page].to_i
    query_params[:page].nil? ? page = 1 : page = query_params[:page].to_i
    # require "pry"; binding.pry
    {
      data: Merchant.all.limit(per_page)
    }
  end

  def self.format(table); end

end
