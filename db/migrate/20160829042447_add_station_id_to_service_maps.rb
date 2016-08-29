class AddStationIdToServiceMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :service_maps, :station_id, :integer
  end
end
