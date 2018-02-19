class ImportConfigs::SuppliersImportConfig < ImportConfigs::Base

  def klass_name
    'Supplier'
  end

  def data_columns
    [ { name: :supplier_code, process: ->(v) { v.to_s }, required: true },
      { name: :name, process: ->(v) { v.to_s }, required: true }]
  end

  def conflict_target
    :supplier_code
  end

  def batch_size
    1000
  end
end
