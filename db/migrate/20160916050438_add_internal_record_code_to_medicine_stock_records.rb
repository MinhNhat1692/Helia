class AddInternalRecordCodeToMedicineStockRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_stock_records, :internal_record_code, :string
  end
end
