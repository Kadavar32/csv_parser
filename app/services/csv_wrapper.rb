class CsvWrapper
  def self.parse(path, columns)
    rows = []

    CSV.foreach(path, { col_sep: '¦'} ) do |row|
      processed_row = parse_row(row, columns)
      next unless processed_row.present?
      rows.push(processed_row) if processed_row.present?
    end

    rows
  end

  def self.parse_row(row, columns)
    columns.each_with_index.map do |col, i|
      value = row[i]
      value = col[:process].call(value) if col[:process].present?
      break if col[:validation].present? && !col[:validation].call(value)
      break if col[:required].present? && value.blank?
      [col[:name], value]
    end.to_h
  end
end
