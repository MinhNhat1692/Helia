class AddCIdToBillInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :bill_infos, :c_id, :integer
  end
end
