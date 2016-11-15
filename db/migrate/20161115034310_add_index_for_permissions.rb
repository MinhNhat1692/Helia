class AddIndexForPermissions < ActiveRecord::Migration[5.0]
  def change
    add_index :permissions, [:employee_id, :station_id, :table_id]
  end
end
