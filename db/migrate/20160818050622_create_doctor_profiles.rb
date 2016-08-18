class CreateDoctorProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :doctor_profiles do |t|
      t.references :user, foreign_key: true
      t.string :fname
      t.string :lname
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
      t.string :avatar
      t.integer :identify
      t.string :noid2
      t.string :activation_digest
      t.boolean :activated
      t.datetime :activated_at

      t.timestamps
    end
  end
end
