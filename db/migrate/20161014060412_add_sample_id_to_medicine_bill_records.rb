class AddSampleIdToMedicineBillRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_bill_records, :sample_id, :integer
  end
end
