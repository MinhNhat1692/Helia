class AddPreparerIdToMedicinePrescriptInternals < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_prescript_internals, :preparer_id, :integer
  end
end
