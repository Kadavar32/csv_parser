class ImportService

  def create(file, config)
    return [] unless config.present?
    rows = CsvWrapper.parse(file.path, config[:data_columns])
    data = import_by_parts(rows, config[:klass_name], batch_size: config[:batch_size], opts: config[:import_opts])
    { resource_type: config[:klass_name], data: data }
  end

  private

  def import_by_parts(rows, klass_name, batch_size: nil, opts: {})
    suppliers_result = []
    klass = klass_name.constantize
    batch_size ||= rows.count / 10
    rows.each_slice(batch_size) do |part|
      suppliers_part = part.map { |e| klass.new(e) }
      suppliers_part = klass.import_with_transaction(suppliers_part, opts)
      suppliers_result += suppliers_part
    end

    suppliers_result
  end
end
