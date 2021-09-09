class MerchantSerializer < JsonSerializer
  class << self
    def all(query_params)
      render_all(query_params, Merchant)
    end

    def find(merchant_id)
      query(Merchant, merchant_id)
    end

    def items(merchant_id)
      output_hash(Item.where(merchant_id: merchant_id))
    end

    def merchant_revenue_keys(revenue_query)
      if revenue_query[:data].instance_of?(Array)
        revenue_query[:data].each { |response_obj| response_obj[:type] = 'merchant_name_revenue' }
      else
        revenue_query[:data][:type] = 'merchant_revenue'
        revenue_query[:data][:attributes] = revenue_query[:data][:attributes].except('name')
      end
      revenue_query
    end

    def top_merchants(results)
      merchant_revenue_keys(output_hash(results))
    end

    def merchant_revenue(merchant_id)
      reformatted = reformat(output_hash(Merchant.revenue_for_merchant(merchant_id)))
      merchant_revenue_keys(reformatted)
    end

    def merchant_shell
      {
        data: {
          Merchant.attribute_names[0] => nil,
          type: 'merchant',
          attributes: {
            Merchant.attribute_names[1] => nil
          }
        }
      }
    end
  end
end
