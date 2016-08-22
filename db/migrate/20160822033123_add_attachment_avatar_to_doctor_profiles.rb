class AddAttachmentAvatarToDoctorProfiles < ActiveRecord::Migration
  def self.up
    change_table :doctor_profiles do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :doctor_profiles, :avatar
  end
end
