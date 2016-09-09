class CreateMedicineCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_companies do |t|
      t.string :name
      t.string :address
      t.string :pnumber
      t.string :noid
      t.string :email
      t.string :website
      t.string :taxcode
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
