class SupportComment < ApplicationRecord
  belongs_to :user
  has_attached_file :attachment
  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
