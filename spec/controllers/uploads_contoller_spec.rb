require 'rails_helper'
RSpec.describe UploadsController, type: :controller do

  describe '#new' do

    subject { get :new }

    it 'renders the new template' do
      expect(subject).to render_template(:new)
    end
  end

  describe '#create' do
    let!(:file) { mock_archive_upload('spec/support/test_files/sku.csv', 'text/csv', 'sku.csv') }
    let(:params) { { file: file } }
    before do
      (1..10).to_a.each { |_e| create(:sku) }
      allow_any_instance_of(UploadsService).to receive(:create).and_return(ServiceResult.new('Sku', Sku.all))
    end

    subject { post :create, params: params }

    it 'renders the new template' do
      expect(subject).to render_template(:create)
    end

    context 'without file' do
      let(:params) { {} }

      it 'raises error' do
        expect(subject).to redirect_to(new_upload_path)
      end
    end
  end
end
