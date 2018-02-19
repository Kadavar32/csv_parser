class Supplier < ActiveRecord::Base
  extend ImportedData
  has_many :skus, foreign_key: 'supplier_code'
end