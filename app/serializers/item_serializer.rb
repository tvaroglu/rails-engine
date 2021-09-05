class ItemSerializer < JsonSerializer
  def self.all(query_params)
    render_all(query_params, Item)
  end

  def self.find(item_id)
    item_query = Item.where(id: item_id)
    reformat_response(output_hash(item_query))
  end

  def self.reformat_response(output_hash)
    if !output_hash[:data].first.nil?
      output_hash[:data].first[:attributes] = output_hash[:data].first[:attributes].except('merchant_id')
      output_hash[:data] = output_hash[:data].first
    else
      output_hash[:data] = item_shell
    end
    output_hash
  end

  def self.item_shell
    {
      id: nil,
      type: 'item',
      attributes: {
        Item.attribute_names[1] => nil,
        Item.attribute_names[2] => nil,
        Item.attribute_names[3] => nil
        }
      }
  end
end
