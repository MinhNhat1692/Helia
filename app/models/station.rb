class Station < ApplicationRecord
  belongs_to :user
  has_many :permissions
  has_attached_file :logo, default_url: "/assets/hospital_missing.png"
  validates_attachment :logo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
