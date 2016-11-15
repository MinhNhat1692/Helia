class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.integer :employee_id
      t.integer :station_id
      t.boolean :can_create, default: false
      t.boolean :can_read, default: false
      t.boolean :can_update, default: false
      t.boolean :can_delete, default: false
      t.integer :table_id

      t.timestamps
    end
  end
end
