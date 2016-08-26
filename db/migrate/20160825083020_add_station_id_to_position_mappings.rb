class AddStationIdToPositionMappings < ActiveRecord::Migration[5.0]
  def change
    add_column :position_mappings, :station_id, :integer
  end
end
