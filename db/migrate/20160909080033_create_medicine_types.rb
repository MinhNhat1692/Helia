class CreateMedicineTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_types do |t|
      t.string :name
      t.text :remark

      t.timestamps
    end
  end
end
