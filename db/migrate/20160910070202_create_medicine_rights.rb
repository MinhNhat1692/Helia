class CreateMedicineRights < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_rights do |t|
      t.references :station, foreign_key: true
      t.integer :user_id
      t.integer :type

      t.timestamps
    end
  end
end
