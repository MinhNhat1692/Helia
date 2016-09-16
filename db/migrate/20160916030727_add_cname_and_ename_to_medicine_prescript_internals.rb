class AddCnameAndEnameToMedicinePrescriptInternals < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_prescript_internals, :cname, :string
    add_column :medicine_prescript_internals, :ename, :string
  end
end
