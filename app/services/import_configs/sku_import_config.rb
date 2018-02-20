class ImportConfigs::SkuImportConfig < ImportConfigs::Base
  def klass_name
    'Sku'
  end

  def data_columns
    [ { name: :sku_code, process: ->(v) { v.to_s }, required: true },
      { name: :supplier_code, process: ->(v) { v.to_s }, required: true },
      { name: :additional_field1 },
      { name: :additional_field2 },
      { name: :additional_field3 },
      { name: :additional_field4 },
      { name: :additional_field5 },
      { name: :additional_field6 },
      { name: :price, process: ->(v) { v.to_f }, validate: ->(v) { v > 0 }, required: true }]
  end

  def conflict_target
    :sku_code
  end

  def batch_size
    2000
  end

  def raw_data_to_object_mapping
    ->(part) do
      supplier_codes = Supplier.where(supplier_code: part.map { |e| e[:supplier_code] }).pluck(:supplier_code)
      part.map { |e| supplier_codes.include?(e[:supplier_code]) ? Sku.new(e) : nil }.compact
    end
  end
end
