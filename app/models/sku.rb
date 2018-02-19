class Sku < ActiveRecord::Base
  extend ImportedData

  belongs_to :supplier, foreign_key: :supplier_code, primary_key: :supplier_code
end