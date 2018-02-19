require 'rails_helper'

RSpec.describe Sku, type: :model do
  describe '#create' do
    let(:supplier) { create(:supplier) }
    let!(:params) { { sku_code: 'SKU1', price: 500, supplier: supplier } }

    subject { Sku.create!(params) }

    it 'creates new Supplier record' do
      expect { subject }.to change(Sku, :count)
    end

    shared_examples 'with ActiveRecord::NotNullViolation Error' do
      it 'raise ActiveRecord::NotNullViolation error' do
        expect { subject }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end

    context 'with missing sku_code' do
      let!(:params) { { price: 500, supplier: supplier } }
      it_behaves_like 'with ActiveRecord::NotNullViolation Error'
    end

    context 'with missing Supplier' do
      let!(:params) { { sku_code: 'SKU1', price: 500 } }
      it 'raise ActiveRecord::NotNullViolation error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
