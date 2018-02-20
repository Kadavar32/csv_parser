class ImportConfigs::Base
  def data_columns; end

  def class_name; end

  def conflict_target; end

  def import_opts; end

  def batch_size; end

  def raw_data_to_object_mapping; end

  def import_config
    columns_to_update = data_columns.map { |e| e[:name] } - [conflict_target]
    import_opts = { validate: false,
                    on_duplicate_key_update:
                        { conflict_target: conflict_target, columns: columns_to_update } }
    { klass_name: klass_name,
      data_columns: data_columns,
      batch_size: batch_size,
      import_opts: import_opts,
      custom_mapping: raw_data_to_object_mapping }
  end
end
