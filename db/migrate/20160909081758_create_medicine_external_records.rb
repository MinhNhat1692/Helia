class CreateMedicineExternalRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_external_records do |t|
      t.references :station, foreign_key: true
      t.integer :customer_id
      t.integer :script_id
      t.string :name
      t.integer :amount
      t.text :remark
      t.string :company
      t.float :price
      t.float :total

      t.timestamps
    end
  end
end
