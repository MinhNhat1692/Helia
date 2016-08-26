class AddAttachmentFileToServices < ActiveRecord::Migration
  def self.up
    change_table :services do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :services, :file
  end
end
