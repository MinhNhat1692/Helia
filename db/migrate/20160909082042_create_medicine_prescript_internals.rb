class CreateMedicinePrescriptInternals < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_prescript_internals do |t|
      t.references :station, foreign_key: true
      t.string :code
      t.integer :customer_id
      t.integer :employee_id
      t.integer :result_id
      t.string :number_id
      t.date :date
      t.string :preparer
      t.string :payer
      t.float :tpayment
      t.float :discount
      t.float :tpayout
      t.integer :pmethod
      t.text :remark

      t.timestamps
    end
  end
end
