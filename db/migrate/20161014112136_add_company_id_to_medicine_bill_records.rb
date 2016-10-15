class AddCompanyIdToMedicineBillRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_bill_records, :company_id, :integer
  end
end
