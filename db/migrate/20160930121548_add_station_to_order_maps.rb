class AddStationToOrderMaps < ActiveRecord::Migration[5.0]
  def change
    add_reference :order_maps, :station, foreign_key: true
  end
end
