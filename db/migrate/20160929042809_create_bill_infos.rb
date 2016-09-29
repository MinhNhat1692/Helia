class CreateBillInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :bill_infos do |t|
      t.text :remark
      t.integer :dvi
      t.integer :sluong
      t.float :tpayment
      t.float :discount
      t.float :tpayout
      t.references :order_map, foreign_key: true

      t.timestamps
    end
  end
end
