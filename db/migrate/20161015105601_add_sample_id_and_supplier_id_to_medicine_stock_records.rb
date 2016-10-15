class AddSampleIdAndSupplierIdToMedicineStockRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_stock_records, :sample_id, :integer
    add_column :medicine_stock_records, :supplier_id, :integer
  end
end
