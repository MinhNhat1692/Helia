class CreateMedicineBillRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_bill_records do |t|
      t.references :station, foreign_key: true
      t.integer :bill_id
      t.string :name
      t.string :company
      t.string :noid
      t.string :signid
      t.date :expire
      t.integer :pmethod
      t.integer :qty
      t.float :taxrate
      t.float :price
      t.text :remark

      t.timestamps
    end
  end
end
