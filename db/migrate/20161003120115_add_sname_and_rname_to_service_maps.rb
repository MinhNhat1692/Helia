class AddSnameAndRnameToServiceMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :service_maps, :sname, :string
    add_column :service_maps, :rname, :string
  end
end
