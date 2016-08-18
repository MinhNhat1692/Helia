class CreateCustomerRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_records do |t|
      t.references :station, foreign_key: true
      t.integer :customer_id
      t.string :cname
      t.date :dob
      t.integer :gender
      t.integer :country
      t.integer :city
      t.integer :province
      t.string :address
      t.string :pnumber
      t.string :noid
      t.date :issue_date
      t.string :issue_place

      t.timestamps
    end
  end
end
