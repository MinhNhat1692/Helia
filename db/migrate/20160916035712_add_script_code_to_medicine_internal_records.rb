class AddScriptCodeToMedicineInternalRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_internal_records, :script_code, :string
  end
end
