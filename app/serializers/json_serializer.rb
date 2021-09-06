class JsonSerializer
  def self.render_all(query_params, table)
    sanitized_params = sanitize_params(query_params, table)
    ranges = pagination_range(sanitized_params[0], sanitized_params[1])
    if query_params[:page].to_i < (table_length(table) / sanitized_params[1])
      records = table.all.order(:id).limit(ranges[1])[ranges[0]..ranges[1]]
    else
      records = []
    end
    output_hash(records)
  end

  def self.output_hash(records)
    records.length.positive? ? hash = { data: format_all(records) } : hash = { data: [] }
    hash
  end

  def self.sanitize_params(params, table)
    [batch(params), batch_size(params, table)]
  end

  def self.table_length(table)
    table.all.length
  end

  def self.batch_size(params, table)
    if params[:per_page].nil? || params[:per_page].to_i <= 0
      per_page = 20
    elsif params[:per_page].to_i >= table_length(table)
      per_page = table_length(table)
    else
      per_page = params[:per_page].to_i
    end
    per_page
  end

  def self.batch(params)
    if params[:page].nil? || params[:page].to_i <= 0
      page = 1
    else
      page = params[:page].to_i
    end
    page
  end

  def self.pagination_range(page, per_page)
    range_end = page * per_page
    range_start = (range_end / page) * (page - 1)
    [range_start, range_end]
  end

  def self.format_all(records)
    records.map do |record|
      {
        id: record.id.to_s,
        type: record.class.to_s.downcase,
        attributes: record.attributes.except('id', 'created_at', 'updated_at')
      }
    end
  end

  def self.reformat(output_hash)
    output_hash[:data] = output_hash[:data].first
    output_hash
  end

  def self.query(table, record_id)
    result = table.where(id: record_id)
    reformat(output_hash(result))
  end
end
