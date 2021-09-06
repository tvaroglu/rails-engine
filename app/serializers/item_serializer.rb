class ItemSerializer < JsonSerializer
  def self.all(query_params)
    render_all(query_params, Item)
  end

  def self.find(item_id)
    query(Item, item_id)
  end

  def self.create(item)
    reformat(output_hash([item]))
  end

  def self.params_error
    { 'error' => 'bad or missing attributes' }
  end

  def self.item_shell
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
