class UploadsController < ApplicationController
  def create
    file = params.require(:file)
    @service_result = UploadsService.new.create(file)
  rescue ActionController::ParameterMissing => e
    redirect_to new_upload_path, flash: { error: "File required!" }
  end

  def new; end
end