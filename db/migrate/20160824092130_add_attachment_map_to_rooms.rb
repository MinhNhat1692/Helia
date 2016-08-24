class AddAttachmentMapToRooms < ActiveRecord::Migration
  def self.up
    change_table :rooms do |t|
      t.attachment :map
    end
  end

  def self.down
    remove_attachment :rooms, :map
  end
end
