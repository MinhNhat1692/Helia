class AddCnameToMedicineInternalRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_internal_records, :cname, :string
  end
end
