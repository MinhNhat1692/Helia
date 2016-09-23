class AddTpaymentAndDiscountAndTpayoutToOrderMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :order_maps, :tpayment, :float
    add_column :order_maps, :discount, :float
    add_column :order_maps, :tpayout, :float
  end
end
