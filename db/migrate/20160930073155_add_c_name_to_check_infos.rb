class AddCNameToCheckInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :check_infos, :c_name, :string
  end
end
