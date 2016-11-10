class Room < ApplicationRecord
  belongs_to :station
  has_many :service_maps, dependent: :destroy
  has_many :positions, dependent: :destroy
  after_update :update_service_map, :update_postions
  has_attached_file :map, :default_url => "assets/noavatar.jpg"
  validates_attachment :map, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  private
    def update_service_map
      ser_maps = self.service_maps
      if ser_maps
        ser_maps.each do |sm|
          sm.update(rname: self.name)
        end
      end
    end

    def update_postions
      positions = self.positions
      if positions
        positions.each do |pos|
          pos.update(rname: self.name)
        end
      end
    end
end
