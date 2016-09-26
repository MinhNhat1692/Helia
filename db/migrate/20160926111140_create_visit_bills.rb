class CreateVisitBills < ActiveRecord::Migration[5.0]
  def change
    create_table :visit_bills do |t|
      t.references :station, foreign_key: true
      t.integer :customer_id
      t.string :cname
      t.string :placecode
      t.integer :billtype
      t.integer :status
      t.integer :pmethod
      t.float :tpayment
      t.float :discount
      t.float :tpayout
      t.string :billcode
      t.text :remark
      t.date :billdate

      t.timestamps
    end
  end
end
