class AddAttachmentAvatarToEmployees < ActiveRecord::Migration
  def self.up
    change_table :employees do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :employees, :avatar
  end
end
