class Position < ApplicationRecord
  belongs_to :station
  belongs_to :room
  has_attached_file :file
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
