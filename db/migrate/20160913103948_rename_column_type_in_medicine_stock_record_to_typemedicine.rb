class RenameColumnTypeInMedicineStockRecordToTypemedicine < ActiveRecord::Migration[5.0]
  def change
    rename_column :medicine_stock_records, :type, :typerecord
  end
end
