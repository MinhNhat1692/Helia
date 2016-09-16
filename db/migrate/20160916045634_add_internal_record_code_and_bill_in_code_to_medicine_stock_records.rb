class AddInternalRecordCodeAndBillInCodeToMedicineStockRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_stock_records, :bill_in_code, :string
  end
end
