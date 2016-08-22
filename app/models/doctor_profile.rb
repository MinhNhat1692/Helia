class DoctorProfile < ApplicationRecord
  belongs_to :user
  has_attached_file :avatar
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
