class ImportService

  def create(file, config)
    return [] unless config.present?
    rows = CsvWrapper.parse(file.path, config[:data_columns])
    data = import_by_parts(rows,
                           config[:klass_name],
                           custom_mapping: config[:custom_mapping],
                           batch_size: config[:batch_size],
                           opts: config[:import_opts])

    { resource_type: config[:klass_name], data: data }
  end

  private

  def import_by_parts(rows, klass_name, custom_mapping: nil, batch_size: nil, opts: {})
    result = []
    klass = klass_name.constantize
    batch_size ||= rows.count / 10
    rows.each_slice(batch_size) do |part|
      part = if custom_mapping.present?
               custom_mapping.call(part)
             else
               part.map { |e| klass.new(e) }
             end

      part = klass.import_with_transaction(part, opts)
      result += part
    end

    result
  end
end
