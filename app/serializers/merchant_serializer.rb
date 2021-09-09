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

    def reassign_type_key(revenue_query)
      revenue_query[:data].each { |response_obj| response_obj[:type] = 'merchant_name_revenue' }
      revenue_query
    end

    def top_merchants(results)
      reassign_type_key(output_hash(results))
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
