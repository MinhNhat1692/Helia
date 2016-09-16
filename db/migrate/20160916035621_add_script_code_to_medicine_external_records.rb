class AddScriptCodeToMedicineExternalRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_external_records, :script_code, :string
  end
end
