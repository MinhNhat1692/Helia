class AddRnameToPositions < ActiveRecord::Migration[5.0]
  def change
    add_column :positions, :rname, :string
  end
end
