class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.string :name, null: false
      t.string :supplier_code, null: false

      t.timestamps
    end

    add_index :suppliers, :supplier_code, unique: true
  end
end
