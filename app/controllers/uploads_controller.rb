class UploadsController < ApplicationController
  def create
    file = params.require(:file)
    limit = params[:limit].to_i
    service_result = UploadsService.new.create(file)

    @resource_type = service_result.resource_type
    @data = limit > 0 ? service_result.data[0..(limit - 1)] : service_result.data
    @error = service_result.error
  rescue ActionController::ParameterMissing => _e
    redirect_to new_upload_path, flash: { error: "File required!" }
  end

  def new; end
end