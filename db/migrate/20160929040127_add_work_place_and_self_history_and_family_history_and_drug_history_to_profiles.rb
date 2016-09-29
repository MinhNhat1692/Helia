class AddWorkPlaceAndSelfHistoryAndFamilyHistoryAndDrugHistoryToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :work_place, :text
    add_column :profiles, :self_history, :text
    add_column :profiles, :family_history, :text
    add_column :profiles, :drug_history, :text
  end
end
