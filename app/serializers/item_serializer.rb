class ItemSerializer < JsonSerializer
  def self.all(query_params)
    render_all(query_params, Item)
  end

  def self.find(item_id)
    query(Item, item_id)
  end

  def self.item_shell
    {
      data: {
        id: nil,
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
