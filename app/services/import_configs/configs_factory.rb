class ImportConfigs::ConfigsFactory
  def self.call(filename)
    case filename
    when 'suppliers.csv'
      ImportConfigs::SuppliersImportConfig.new.import_config
    when 'sku.csv'
      ImportConfigs::SkuImportConfig.new.import_config
    end
  end
end
