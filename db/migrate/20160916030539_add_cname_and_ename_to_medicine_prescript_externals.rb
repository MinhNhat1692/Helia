class AddCnameAndEnameToMedicinePrescriptExternals < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_prescript_externals, :cname, :string
    add_column :medicine_prescript_externals, :ename, :string
  end
end
