class DoctorProfile < ApplicationRecord
  belongs_to :user
  has_attached_file :avatar, default_url: "/assets/avatar_missing.png"
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
