class AddSampleIdAndCompanyIdToMedicineExternalRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_external_records, :sample_id, :integer
    add_column :medicine_external_records, :company_id, :integer
  end
end
