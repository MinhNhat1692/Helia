class AddCIdToDoctorCheckInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :doctor_check_infos, :c_id, :integer
  end
end
