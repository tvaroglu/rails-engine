class ItemSerializer < JsonSerializer
  def self.all(query_params)
    render_all(query_params, Item)
  end
end
