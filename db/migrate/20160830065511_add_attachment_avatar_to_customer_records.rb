class AddAttachmentAvatarToCustomerRecords < ActiveRecord::Migration
  def self.up
    change_table :customer_records do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :customer_records, :avatar
  end
end
