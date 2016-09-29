class CreateDoctorCheckInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :doctor_check_infos do |t|
      t.date :daycheck
      t.string :ename
      t.integer :e_id
      t.text :qtbenhly
      t.text :klamsang
      t.integer :nhiptim
      t.float :nhietdo
      t.integer :hamin
      t.integer :hamax
      t.integer :ntho
      t.float :cnang
      t.float :cao
      t.text :cdbandau
      t.text :bktheo
      t.text :cdicd
      t.text :kluan
      t.references :order_map, foreign_key: true

      t.timestamps
    end
  end
end
