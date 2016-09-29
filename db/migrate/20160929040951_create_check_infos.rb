class CreateCheckInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :check_infos do |t|
      t.string :ename
      t.integer :e_id
      t.integer :status
      t.date :daystart
      t.date :dayend
      t.text :kluan
      t.text :cdoan
      t.text :hdieutri
      t.references :order_map, foreign_key: true

      t.timestamps
    end
  end
end
