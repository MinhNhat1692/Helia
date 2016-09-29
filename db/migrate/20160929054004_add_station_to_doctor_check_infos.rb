class AddStationToDoctorCheckInfos < ActiveRecord::Migration[5.0]
  def change
    add_reference :doctor_check_infos, :station, foreign_key: true
  end
end
