class AddCnameToMedicineExternalRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_external_records, :cname, :string
  end
end
