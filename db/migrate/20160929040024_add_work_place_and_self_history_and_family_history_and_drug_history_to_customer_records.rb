class AddWorkPlaceAndSelfHistoryAndFamilyHistoryAndDrugHistoryToCustomerRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_records, :work_place, :text
    add_column :customer_records, :self_history, :text
    add_column :customer_records, :family_history, :text
    add_column :customer_records, :drug_history, :text
  end
end
