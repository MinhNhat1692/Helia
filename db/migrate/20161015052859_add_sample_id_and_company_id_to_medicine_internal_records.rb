class AddSampleIdAndCompanyIdToMedicineInternalRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_internal_records, :sample_id, :integer
    add_column :medicine_internal_records, :company_id, :integer
  end
end
