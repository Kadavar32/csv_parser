class CreateSkus < ActiveRecord::Migration[5.1]
  def change
    create_table :skus do |t|
      t.string :sku_code, null: false
      t.string :supplier_code, null: false
      t.string :additional_field1
      t.string :additional_field2
      t.string :additional_field3
      t.string :additional_field4
      t.string :additional_field5
      t.string :additional_field6
      t.decimal :price, default: 0

      t.timestamps
    end
    #
    add_index :skus, :sku_code, unique: true
  end
end
