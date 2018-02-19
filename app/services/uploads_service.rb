class UploadsService
  include Errors
  include Errors::ErrorMessages

  def initialize
    @result = ServiceResult.new(nil, nil, nil)
  end

  def create(file)
    return @result unless validate_file(file)
    config = load_config(file.original_filename)
    return @result unless config.present?
    import_result = ImportService.new.create(file, config)
    @result.resource_type, @result.data = [import_result[:resource_type], import_result[:data]]
  rescue => e
    @result.error = e.message
  ensure
    return @result
  end

  private

  def load_config(filename)
    config = ImportConfigs::ConfigsFactory.call(filename)
    @result.error = UNKNOWN_FILE unless config

    config
  end

  def validate_file(file)
    if file.content_type == "text/csv"
      true
    else
      @result.error = INVALID_FILE_FORMAT
      false
    end
  end
end