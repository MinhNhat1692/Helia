class AddStationToBillInfos < ActiveRecord::Migration[5.0]
  def change
    add_reference :bill_infos, :station, foreign_key: true
  end
end
