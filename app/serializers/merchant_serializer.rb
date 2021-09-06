class MerchantSerializer < JsonSerializer
  def self.all(query_params)
    render_all(query_params, Merchant)
  end

  def self.find(merchant_id)
    query(Merchant, merchant_id)
  end

  def self.merchant_shell
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
