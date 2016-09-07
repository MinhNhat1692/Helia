class Room < ApplicationRecord
  belongs_to :station
  has_many :service_maps, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_attached_file :map
  validates_attachment :map, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
