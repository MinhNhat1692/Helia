class AddRemarkToMedicineStockRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_stock_records, :remark, :text
  end
end
