class AddAttachmentFileToPositions < ActiveRecord::Migration
  def self.up
    change_table :positions do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :positions, :file
  end
end
