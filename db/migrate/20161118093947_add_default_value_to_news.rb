class AddDefaultValueToNews < ActiveRecord::Migration[5.0]
  def up
    change_column :news, :views, :integer, default: 0
  end

  def down
    change_column :news, :views, :integer, default: nil
  end
end
