class ServiceResult
  attr_accessor :resource_type, :error, :data

  def initialize(resource_type, data, error = nil)
    @resource_type = resource_type
    @data = data
    @error = error
  end
end
