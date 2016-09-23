class AddCnameAndSernameToOrderMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :order_maps, :cname, :string
    add_column :order_maps, :sername, :string
  end
end
