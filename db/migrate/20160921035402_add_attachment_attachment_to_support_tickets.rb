class AddAttachmentAttachmentToSupportTickets < ActiveRecord::Migration
  def self.up
    change_table :support_tickets do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :support_tickets, :attachment
  end
end
