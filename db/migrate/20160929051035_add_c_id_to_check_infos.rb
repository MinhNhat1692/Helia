class AddCIdToCheckInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :check_infos, :c_id, :integer
  end
end
