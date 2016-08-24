class Room < ApplicationRecord
  belongs_to :station
  has_attached_file :map
  validates_attachment :map, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
