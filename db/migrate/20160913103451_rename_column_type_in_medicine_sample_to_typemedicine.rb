class RenameColumnTypeInMedicineSampleToTypemedicine < ActiveRecord::Migration[5.0]
  def change
    rename_column :medicine_samples, :type, :typemedicine
  end
end
