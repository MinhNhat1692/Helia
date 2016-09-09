class CreateMedicineStockRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_stock_records do |t|
      t.references :station, foreign_key: true
      t.integer :type
      t.string :name
      t.string :noid
      t.string :signid
      t.integer :amount
      t.date :expire
      t.string :supplier
      t.integer :internal_record_id
      t.integer :bill_in_id

      t.timestamps
    end
  end
end
