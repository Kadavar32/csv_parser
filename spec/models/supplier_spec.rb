require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#create' do
    let!(:params) { { supplier_code: 's001', name: 'name' } }

    subject { Supplier.create!(params) }

    it 'creates new Supplier record' do
      expect { subject }.to change(Supplier, :count)
    end

    shared_examples 'with ActiveRecord::NotNullViolation Error' do
      it 'raise ActiveRecord::NotNullViolation error' do
        expect { subject }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end

    context 'with missing supplier_code' do
      let(:params) { { name: 'name' } }
      it_behaves_like 'with ActiveRecord::NotNullViolation Error'
    end

    context 'with missing name' do
      let(:params) { { supplier_code: 's001' } }
      it_behaves_like 'with ActiveRecord::NotNullViolation Error'
    end
  end
end
