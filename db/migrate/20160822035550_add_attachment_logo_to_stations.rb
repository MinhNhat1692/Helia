class AddAttachmentLogoToStations < ActiveRecord::Migration
  def self.up
    change_table :stations do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :stations, :logo
  end
end
