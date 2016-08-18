class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.references :user, foreign_key: true
      t.string :sname
      t.integer :country
      t.integer :city
      t.integer :province
      t.string :address
      t.string :pnumber
      t.string :hpage
      t.string :logo
      t.string :activation_digest
      t.boolean :activated
      t.datetime :activated_at
      t.string :Noid
      t.date :date_issue
      t.string :place_issue
      t.string :mst

      t.timestamps
    end
  end
end
