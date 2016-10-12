class Position < ApplicationRecord
  belongs_to :station
  belongs_to :room
  has_many :position_mappings, dependent: :destroy
  has_attached_file :file, :default_url => "assets/noavatar.jpg"
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
