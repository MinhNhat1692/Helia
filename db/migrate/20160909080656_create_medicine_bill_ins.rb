class CreateMedicineBillIns < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_bill_ins do |t|
      t.string :billcode
      t.date :dayin
      t.string :supplier
      t.date :daybook
      t.integer :pmethod
      t.float :tpayment
      t.float :discount
      t.float :tpayout
      t.text :remark
      t.integer :status
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
