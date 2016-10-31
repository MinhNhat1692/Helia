class CreateDemoRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :demo_requests do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :sname
      t.string :pnumber
      t.datetime :demotime

      t.timestamps
    end
  end
end
