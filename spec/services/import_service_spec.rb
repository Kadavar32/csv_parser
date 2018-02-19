require 'rails_helper'
include Errors::ErrorMessages

describe ImportService, type: :service do
  describe '#create' do
    subject { ImportService.new.create(file, config) }

    context 'with sku config' do
      let(:config) { ImportConfigs::ConfigsFactory.call('sku.csv') }
      let!(:file) { mock_archive_upload('spec/support/test_files/sku.csv', 'text/csv', 'sku.csv') }
      let(:supplier_code) { 's0001' }
      let!(:supplier) { create(:supplier, supplier_code: supplier_code) }

      it 'add new sku records if not exist' do
        expect(Sku.count).to eq 0
        expect { subject }.to change(Sku, :count)
      end

      it 'returns Sku relation' do
        result = subject
        data = result[:data]
        expect(data.first.is_a?(Sku)).to be true
      end

      context 'when supplier is not exist' do
        it 'return non persisted sku with id = nil' do
          result = subject
          data = result[:data]
          expect(data.first.supplier_code).to eq supplier_code
          expect(data.last.id).to eq nil
        end
      end

      context 'when Sku already exist' do
        let(:old_price) { '12' }
        let!(:sku) { create(:sku, sku_code: '00000001', supplier: supplier, price: old_price) }

        it 'updates Sku record' do
          expect { subject }.to change { sku.reload.price }
        end
      end
    end

    context 'with supplier config' do
      let!(:file) { mock_archive_upload('spec/support/test_files/suppliers.csv', 'text/csv', 'suppliers.csv') }
      let(:config) { ImportConfigs::ConfigsFactory.call('suppliers.csv') }

      it 'create records if not exist' do
        expect(Supplier.count).to eq 0
        expect { subject }.to change(Supplier, :count)
      end

      it 'returns Supplier relation' do
        result = subject
        data = result[:data]
        expect(data.first.is_a?(Supplier)).to be true
      end

      context 'when supplier record already exists' do
        let(:supplier_code) { 's0210' }
        let(:supplier_old_name) { 'old_name' }
        let!(:existing_supplier) { create(:supplier, supplier_code: supplier_code, name: supplier_old_name) }

        it 'updates record' do
          expect { subject }.to change{ existing_supplier.reload.name }
        end
      end
    end
  end
end
