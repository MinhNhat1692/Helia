class Profile < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  has_attached_file :avatar
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  # Explicitly do not validate
  #do_not_validate_attachment_file_type :avatar
end
