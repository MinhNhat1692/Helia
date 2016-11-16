class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :station_id
      t.boolean :c_permit, default: false
      t.boolean :r_permit, default: false
      t.boolean :u_permit, default: false
      t.boolean :d_permit, default: false
      t.integer :table_id

      t.timestamps
    end
  end
end
