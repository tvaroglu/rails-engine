class JsonSerializer
  class << self
    def render_all(query_params, table)
      sanitized_params = sanitize_params(query_params, table)
      ranges = pagination_range(sanitized_params[:batch], sanitized_params[:batch_size])
      if query_params[:page].to_i < (table_length(table) / sanitized_params[:batch_size])
        records = table.all.limit(ranges[:end])[ranges[:start]..ranges[:end]]
      else
        records = []
      end
      output_hash(records)
    end

    def table_length(table)
      table.all.length
    end

    def sanitize_params(params, table)
      { batch: batch(params), batch_size: batch_size(params, table) }
    end

    def batch_size(params, table)
      if params[:per_page].nil? || params[:per_page].to_i <= 0
        per_page = 20
      elsif params[:per_page].to_i >= table_length(table)
        per_page = table_length(table)
      else
        per_page = params[:per_page].to_i
      end
      per_page
    end

    def batch(params)
      if params[:page].nil? || params[:page].to_i <= 0
        page = 1
      else
        page = params[:page].to_i
      end
      page
    end

    def pagination_range(page, per_page)
      range_end = page * per_page
      range_start = (range_end / page) * (page - 1)
      { start: range_start, end: range_end }
    end

    def format_all(records)
      records.map do |record|
        {
          id: record.id.to_s,
          type: record.class.to_s.downcase,
          attributes: record.attributes.except('id', 'created_at', 'updated_at')
        }
      end
    end

    def reformat(output_hash)
      output_hash[:data] = output_hash[:data].first
      output_hash
    end

    def output_hash(records)
      records.length.positive? ? hash = { data: format_all(records) } : hash = { data: [] }
      hash
    end

    def query(table, record_id)
      result = table.where(id: record_id)
      reformat(output_hash(result))
    end

    def params_error
      { 'error' => 'bad or missing parameters' }
    end
  end
end
