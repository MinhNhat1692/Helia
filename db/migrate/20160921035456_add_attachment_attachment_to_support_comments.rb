class AddAttachmentAttachmentToSupportComments < ActiveRecord::Migration
  def self.up
    change_table :support_comments do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :support_comments, :attachment
  end
end
