class AddRemarkToOrderMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :order_maps, :remark, :text
  end
end
