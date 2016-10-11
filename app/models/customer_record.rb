class CustomerRecord < ApplicationRecord
  belongs_to :station
  has_attached_file :avatar, :default_url => "assets/noavatar.jpg"
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
