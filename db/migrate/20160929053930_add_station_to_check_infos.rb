class AddStationToCheckInfos < ActiveRecord::Migration[5.0]
  def change
    add_reference :check_infos, :station, foreign_key: true
  end
end
