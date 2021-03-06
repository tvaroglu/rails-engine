class ItemSerializer < JsonSerializer
  class << self
    def all(query_params)
      render_all(query_params, Item)
    end

    def find(item_id)
      query(Item, item_id)
    end

    def update(params, item_params)
      found_item = Item.find(params[:id])
      found_item.update(item_params) if found_item
      reformat(output_hash([found_item]))
    end

    def merchant(item_id)
      found_merchant = Merchant.where(id: Item.find(item_id).merchant_id)
      reformat(output_hash(found_merchant))
    end

    def item_revenue_keys(revenue_query)
      revenue_query[:data].each { |response_obj| response_obj[:type] = 'item_revenue' }
      revenue_query
    end

    def top_items_by_revenue(results)
      item_revenue_keys(output_hash(results))
    end

    def item_shell
      {
        data: {
          Item.attribute_names[0] => nil,
          type: 'item',
          attributes: {
            Item.attribute_names[1] => nil,
            Item.attribute_names[2] => nil,
            Item.attribute_names[3] => nil,
            Item.attribute_names[4] => nil
          }
        }
      }
    end
  end
end
