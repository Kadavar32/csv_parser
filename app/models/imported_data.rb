module ImportedData
  def import_with_transaction(data_arr, opts)
    self.transaction do
      self.lock
      self.import data_arr, opts
      data_arr
    end
  end
end
