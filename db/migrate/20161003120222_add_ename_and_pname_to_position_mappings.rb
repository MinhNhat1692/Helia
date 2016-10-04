class AddEnameAndPnameToPositionMappings < ActiveRecord::Migration[5.0]
  def change
    add_column :position_mappings, :ename, :string
    add_column :position_mappings, :pname, :string
  end
end
