class CreateMedicineInternalRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_internal_records do |t|
      t.references :station, foreign_key: true
      t.integer :customer_id
      t.integer :script_id
      t.string :name
      t.integer :amount
      t.string :noid
      t.string :signid
      t.text :remark
      t.string :company
      t.float :price
      t.float :discount
      t.float :tpayment
      t.integer :status

      t.timestamps
    end
  end
end
