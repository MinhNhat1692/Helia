class CreateMedicineSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_suppliers do |t|
      t.string :name
      t.string :contactname
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :spnumber
      t.string :pnumber
      t.string :noid
      t.string :email
      t.string :facebook
      t.string :twitter
      t.string :fax
      t.string :taxcode
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
