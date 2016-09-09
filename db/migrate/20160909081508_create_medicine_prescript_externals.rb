class CreateMedicinePrescriptExternals < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_prescript_externals do |t|
      t.references :station, foreign_key: true
      t.string :code
      t.integer :customer_id
      t.integer :employee_id
      t.integer :result_id
      t.string :number_id
      t.date :date
      t.string :address
      t.text :remark

      t.timestamps
    end
  end
end
