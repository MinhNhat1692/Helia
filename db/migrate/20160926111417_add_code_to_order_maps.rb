class AddCodeToOrderMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :order_maps, :code, :string
  end
end
