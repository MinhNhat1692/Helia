class RenameColumnGroupFromMedicineSamplesToGroupmedicine < ActiveRecord::Migration[5.0]
  def change
    rename_column :medicine_samples, :group, :groupmedicine
  end
end
