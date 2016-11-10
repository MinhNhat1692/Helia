class Service < ApplicationRecord
  belongs_to :station
  has_many :service_maps, dependent: :destroy
  after_update :update_service_map
  has_attached_file :file
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  private
    def update_service_map
      ser_maps = self.service_maps
      if ser_maps
        ser_maps.each do |sm|
          sm.update(sname: self.sname)
        end
      end
    end
end
