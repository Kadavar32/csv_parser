require 'rails_helper'
include Errors::ErrorMessages

describe UploadsService, type: :service do
  describe '#create' do
    let!(:file) { mock_archive_upload('spec/support/test_files/sku.csv', 'text/csv', 'sku.csv') }
    subject { UploadsService.new.create(file) }

    shared_examples 'error case with error' do |error|
      it 'has error in result' do
        service_result = subject
        expect(service_result).is_a?(ServiceResult)
        expect(service_result.error).to be_present
        expect(service_result.error).to eq error
      end
    end

    shared_examples 'has data in result' do |resource|
      it 'has data in result' do
        service_result = subject
        expect(service_result).is_a?(ServiceResult)
        expect(service_result.error).not_to be_present
        expect(service_result.resource_type).to be_present
        expect(service_result.resource_type).to eq resource
        expect(service_result.data).to be_present
        expect(service_result.data.first.is_a?(resource.constantize)).to be true
      end
    end

    context 'with wrong content type' do
      let!(:file) { mock_archive_upload('spec/support/test_files/sku.csv', 'wrong type', 'invalidname') }

      it_behaves_like 'error case with error', INVALID_FILE_FORMAT
    end

    context 'with invalid file name' do
      let!(:file) { mock_archive_upload('spec/support/test_files/sku.csv', 'text/csv', 'invalidname') }

      it_behaves_like 'error case with error', UNKNOWN_FILE
    end

    context 'with supplier file' do
      let(:file) { mock_archive_upload('spec/support/test_files/suppliers.csv', 'text/csv', 'suppliers.csv') }

      before do
        @data = Supplier.all
        (1..5).to_a.each { |_e| create(:supplier) }
        allow_any_instance_of(ImportService).to receive(:create).and_return({ resource_type: 'Supplier', data: @data })
      end

      it_behaves_like 'has data in result', 'Supplier'
    end

    context 'with sku file' do
      let(:file) { mock_archive_upload('spec/support/test_files/suppliers.csv', 'text/csv', 'sku.csv') }

      before do
        @data = Sku.all
        (1..5).to_a.each { |_e| create(:sku) }
        allow_any_instance_of(ImportService).to receive(:create).and_return({ resource_type: 'Sku', data: @data })
      end

      it_behaves_like 'has data in result', 'Sku'
    end
  end

  def mock_archive_upload(archive_path, type, filename)
    tempfile = File.new(Rails.root + archive_path, type: type)
    file = ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: filename, type: type)

    file
  end
end

